#!/bin/bash -l

# directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)
###################################

{ read -r HC_SNPfilt; } < <(yq -y '.paths."5_HC_SNP_filt"' sources.yaml)
HC_SNPfilt=${main_dir}${HC_SNPfilt}

{ read -r SNP_sites; } < <(yq -y '.paths."5_SNPsites"' sources.yaml)
SNPsites=${main_dir}${SNP_sites}

{ read -r SNP_sitesLog; } < <(yq -y '.paths."5_SNPsitesLog"' sources.yaml)
SNPsitesLog=${main_dir}${SNP_sitesLog}

{ read -r SNP_merge; } < <(yq -y '.paths."5_SNPmerge"' sources.yaml)
SNPmerge=${main_dir}${SNP_merge}

{ read -r SNP_mergeLog; } < <(yq -y '.paths."5_SNPmergeLog"' sources.yaml)
SNPmergeLog=${main_dir}${SNP_mergeLog}

{ read -r SNP_eq3; } < <(yq -y '.paths."5_SNPeq3"' sources.yaml)
SNPeq3=${main_dir}${SNP_eq3}

{ read -r SNP_eq3Log; } < <(yq -y '.paths."5_SNPeq3Log"' sources.yaml)
SNPeq3Log=${main_dir}${SNP_eq3Log}

{ read -r SNP_counts; } < <(yq -y '.paths."5_counts"' sources.yaml)
SNPcounts=${main_dir}${SNP_counts}

{ read -r SNP_countsLog; } < <(yq -y '.paths."5_countsLog"' sources.yaml)
SNPcountsLog=${main_dir}${SNP_countsLog}

# the script outputs log files and 2 types of vcf files:
# one with only the SNPs that are confirmed in the same location for each of the replicates
# the other with all the SNPs, even if they appear in just 1 replicate

arr_sample_names=(totRNA_mock totRNA_arsenite totRNA_HS totRNA_NaCl totRNA_UV sgRNA_arsenite sgRNA_HS sgRNA_NaCl sgRNA_UV)
##########################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

echo "Get consensus SNPs in 3 replicates"
#echo "5 ${arr_sample_names[@]}"
#echo "6 ${!arr_sample_names[@]}"

for i in ${!arr_sample_names[@]}
do
    echo "${arr_sample_names[$i]}"
    
    ## get the vcf and txt files with consensus mutations in replicates
    bcftools isec -Oz -p ${SNPsites}'/'${arr_sample_names[$i]}'_eq3' -n=3 \
        ${HC_SNPfilt}'/s'$((3*$i+1))'_SNPfilt_expanded.vcf.gz' \
        ${HC_SNPfilt}'/s'$((3*$i+2))'_SNPfilt_expanded.vcf.gz' \
        ${HC_SNPfilt}'/s'$((3*$i+3))'_SNPfilt_expanded.vcf.gz' \
        2>${SNPsitesLog}'/'${arr_sample_names[$i]}'_eq3.log'
    

    cut -f 1-2 ${SNPsites}'/'${arr_sample_names[$i]}'_eq3/sites.txt' > tmp && mv tmp ${SNPsites}'/'${arr_sample_names[$i]}'_eq3/sites_eq3.txt' 

    ## merge each of the 3 replication files to get a SNP merged file per experimental condition
    bcftools merge -Oz -o ${SNPmerge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        ${HC_SNPfilt}'/s'$((3*$i+1))'_SNPfilt_expanded.vcf.gz' \
        ${HC_SNPfilt}'/s'$((3*$i+2))'_SNPfilt_expanded.vcf.gz' \
        ${HC_SNPfilt}'/s'$((3*$i+3))'_SNPfilt_expanded.vcf.gz' \
        2>${SNPmergeLog}'/'${arr_sample_names[$i]}'_merge.log'

    tabix -p vcf ${SNPmerge}'/'${arr_sample_names[$i]}'_merge.vcf.gz'
    
    ## extract from the vcfs only the needed positions
    bcftools view -Oz -R ${SNPsites}'/'${arr_sample_names[$i]}'_eq3/sites_eq3.txt' \
        ${SNPmerge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        -o ${SNPeq3}'/'${arr_sample_names[$i]}'_merge_eq3.vcf.gz' \
        2>${SNPeq3Log}'/'${arr_sample_names[$i]}'_merge_eq3.log';  \
        tabix -p vcf ${SNPeq3}'/'${arr_sample_names[$i]}'_merge_eq3.vcf.gz'
done


echo "Get row names for stats"
## extract all the mutations from the files
#cd ${SNPeq3}

## create the row names:
bcftools stats ${SNPmerge}'/totRNA_mock_merge.vcf.gz' | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/' | cut -f 3  | sed -e '1d;2d;$d' | tee ${SNPcounts}'/mutations_all.txt' ${SNPcounts}'/mutations_eq3.txt'
#######################################

## SAMPLES WITH ALL MUTATIONS (filtered)
echo "Get stats for files with all mutations"
## get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find ${SNPmerge} -maxdepth 1 -iname "*merge.vcf.gz"| sort -rV)
do 
    echo "$(basename ${i%%_merge*})"; bcftools stats $i | \
        awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| \
        cut -f 4 | sed -e '1d;2d;$d'| \
        paste ${SNPcounts}'/mutations_all.txt' - > tmp4.txt;
        mv -f tmp4.txt ${SNPcounts}'/mutations_all.txt'
done 

## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${SNPcounts}'/mutations_all.txt') > tmp4.txt  &&  mv -f tmp4.txt ${SNPcounts}'/mutations_all.txt' 

## insert 'mutation' as name of col 1
sed "1s/^/mutation\t/" ${SNPcounts}'/mutations_all.txt' > tmp4.txt && mv -f tmp4.txt ${SNPcounts}'/mutations_all.txt'


## SAMPLES WITH the mutations that appear in all 3 replicates (filtered)
echo "Get stats for files with identical mutations in all replicates"
#get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find ${SNPeq3} -maxdepth 1 -iname "*merge_eq3.vcf.gz"| sort -rV)
do 
    echo "$(basename ${i%%_merge*})"; bcftools stats $i | \
        awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| \
        cut -f 4 | sed -e '1d;2d;$d'| \
        paste ${SNPcounts}'/mutations_eq3.txt' - > tmp4.txt;  
        mv -f tmp4.txt ${SNPcounts}'/mutations_eq3.txt' 
done  

## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${SNPcounts}'/mutations_eq3.txt') > tmp4.txt  &&  mv -f tmp4.txt ${SNPcounts}'/mutations_eq3.txt' 

## insert 'mutation' as name of col 1
sed "1s/^/mutation\t/" ${SNPcounts}'/mutations_eq3.txt' > tmp4.txt && mv -f tmp4.txt ${SNPcounts}'/mutations_eq3.txt'

t30=$(date +%s)

echo "Processing complete at $(date +"%x %r %Z")"
