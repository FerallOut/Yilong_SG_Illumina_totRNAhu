#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules
module load bcftools

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript'
out_tsvs=${main_dir}'/5_SNP_TtoCmutation_analysis/10b_plots_mutations/1_SNPs_filtPASS_noMultiallelic_vcfs'
in_vcfs=${main_dir}'/5_SNP_TtoCmutation_analysis/7b_bam_RG_merge_GATKcorr_HC_vcfs_QD2.0_FS60.0_MQ_40.0_HS_13.0_MQRS12.5'
in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
out_txt=${main_dir}'/5_SNP_TtoCmutation_analysis/10b_plots_mutations/2_consensus_replicates_SNPs_txt'
out_merge=${main_dir}'/5_SNP_TtoCmutation_analysis/10b_plots_mutations/3_merged_replicates_SNPs'
dir_counts=${main_dir}'/5_SNP_TtoCmutation_analysis/10b_plots_mutations/4_mutation_counts'

#mkdir -p ${out_txt} ${out_merge} ${dir_counts}
 
arr_sample_names=(totRNA_mock totRNA_arsenite totRNA_HS totRNA_NaCl totRNA_UV sgRNA_arsenite sgRNA_HS sgRNA_NaCl sgRNA_UV)

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
gtf_zip=${main_dir}'/5_SNP_TtoCmutation_analysis/9b_annot_vcfs/vep/references/hg38_p27.gtf.gz'
##########################################################################
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

for k in $(find ${in_bam} -iname '*.bam' | sort -V)
do 
    echo $(basename ${k%%.bam*})
    echo "Remove multiallelic entries"  

    bcftools view --max-alleles 2 --threads 8 --min-alleles 2 ${in_vcfs}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_filtPASS.vcf.gz' \
        -o ${out_tsvs}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf'
   
    bgzip -@ 20 ${out_tsvs}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf'
    tabix -p vcf ${out_tsvs}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf.gz' 
done

echo "Get consensus SNPs in 2 or 3 replicates"
#echo "5 ${arr_sample_names[@]}"
#echo "6 ${!arr_sample_names[@]}"

for i in ${!arr_sample_names[@]}
do
    #echo "$i" 
    echo "${arr_sample_names[$i]}"
    #echo "2 ${arr_sample_names[$i+1]}"
    
    ## get the vcf and txt files with consensus mutations in replicates
    bcftools isec -Oz -p ${out_txt}'/'${arr_sample_names[$i]}'_gt2' -n+2 \
        ${out_tsvs}'/s'$((3*$i+1))'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf.gz' \
        ${out_tsvs}'/s'$((3*$i+2))'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf.gz' \
        ${out_tsvs}'/s'$((3*$i+3))'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf.gz' 
    
    mv ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites.txt' ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt'
 
    awk '$5=="111" {print $0}' ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' > ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt'

    cut -f 1-2 ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' > tmp && mv tmp ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' 
    cut -f 1-2 ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt' > tmp && mv tmp ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt' 


    ## merge each of the 3 replication files to get a merged file per experimental condition
    bcftools merge -Oz -o ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        ${out_tsvs}'/s'$((3*$i+1))'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf.gz' \
        ${out_tsvs}'/s'$((3*$i+2))'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf.gz' \
        ${out_tsvs}'/s'$((3*$i+3))'_GATKCorr_SNPs_filtPASS_noMultiallelic.vcf.gz' 

    tabix -p vcf ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz'

   ## extract from the vcfs only the needed positions
    bcftools view -Oz -R ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' \
        ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        -o ${out_merge}'/'${arr_sample_names[$i]}'_merge_gt2.vcf.gz' && tabix -p vcf ${out_merge}'/'${arr_sample_names[$i]}'_merge_gt2.vcf.gz'
   
    bcftools view -Oz -R ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt' \
        ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        -o ${out_merge}'/'${arr_sample_names[$i]}'_merge_eq3.vcf.gz' && tabix -p vcf ${out_merge}'/'${arr_sample_names[$i]}'_merge_eq3.vcf.gz'
done


## extract all the mutations from the files
cd ${out_merge}

## create the row names:
bcftools stats ${out_merge}'/totRNA_mock_merge.vcf.gz' | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/' | cut -f 3  | sed -e '1d;2d;$d' | tee ${dir_counts}'/mutations_all.txt' ${dir_counts}'/mutations_gt2.txt' ${dir_counts}'/mutations_eq3.txt'


## SAMPLES WITH ALL MUTATIONS (filtered)
## get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find . -maxdepth 1 -iname "*merge.vcf.gz"| sort -rV); do echo "$(basename ${i%%_merge*})"; bcftools stats $i | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| cut -f 4 | sed -e '1d;2d;$d'| paste ${dir_counts}'/mutations_all.txt' - > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_all.txt' ; done 
## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${dir_counts}'/mutations_all.txt') > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_all.txt' 
## insert 'mutation' as name of col 1
sed "1s/^/mutation\t/" ${dir_counts}'/mutations_all.txt' > tmp4.txt && mv -f tmp4.txt ${dir_counts}'/mutations_all.txt'


## SAMPLES WITH the mutations that appear in all 3 replicates (filtered)
#get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find . -maxdepth 1 -iname "*merge_eq3.vcf.gz"| sort -rV); do echo "$(basename ${i%%_merge*})"; bcftools stats $i | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| cut -f 4 | sed -e '1d;2d;$d'| paste ${dir_counts}'/mutations_eq3.txt' - > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_eq3.txt' ; done  
## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${dir_counts}'/mutations_eq3.txt') > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_eq3.txt' 
## insert 'mutation' as name of col 1
sed "1s/^/mutation\t/" ${dir_counts}'/mutations_eq3.txt' > tmp4.txt && mv -f tmp4.txt ${dir_counts}'/mutations_eq3.txt'


## SAMPLES WITH the mutations that appear in at least 2 replicates (filtered)
## get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find . -maxdepth 1 -iname "*merge_gt2.vcf.gz"| sort -rV); do echo "$(basename ${i%%_merge*})"; bcftools stats $i | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| cut -f 4 | sed -e '1d;2d;$d'| paste ${dir_counts}'/mutations_gt2.txt' - > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_gt2.txt' ; done  
## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${dir_counts}'/mutations_gt2.txt') > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_gt2.txt' 
## insert 'mutation' as name of col 1
sed "1s/^/mutation\t/" ${dir_counts}'/mutations_gt2.txt' > tmp4.txt && mv -f tmp4.txt ${dir_counts}'/mutations_gt2.txt'


t30=$(date +%s)

echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"
