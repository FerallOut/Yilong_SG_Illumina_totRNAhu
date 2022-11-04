#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules
module load bcftools

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript/5_SNP_TtoCmutation_analysis'
in_vcfs=${main_dir}'/8c_GATKcorr_ERC_VarFilt_DPgt10'
out_txt=${in_vcfs}'/trial2_counts_each_sample/1_out_txt'

out_merge=${in_vcfs}'/trial2_counts_each_sample/2_merged_replicates_SNPs'
#dir_counts=${main_dir}'/trial2_counts_each_sample/3_base_counts'
#mkdir -p ${out_txt} ${out_merge} ${dir_counts}
 
arr_sample_names=(totRNA_mock totRNA_arsenite totRNA_HS totRNA_NaCl totRNA_UV sgRNA_arsenite sgRNA_HS sgRNA_NaCl sgRNA_UV)

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
gtf_zip=${main_dir}'/5_SNP_TtoCmutation_analysis/9b_annot_vcfs/vep/references/hg38_p27.gtf.gz'
##########################################################################
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

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
        ${in_vcfs}'/s'$((3*$i+1))'_ERC_VarFilt_DPgt10.vcf.gz' \
        ${in_vcfs}'/s'$((3*$i+2))'_ERC_VarFilt_DPgt10.vcf.gz' \
        ${in_vcfs}'/s'$((3*$i+3))'_ERC_VarFilt_DPgt10.vcf.gz' 
    
    mv ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites.txt' ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt'
 
    awk '$5=="111" {print $0}' ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' > ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt'

    cut -f 1-2 ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' > tmp && mv tmp ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' 
    cut -f 1-2 ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt' > tmp && mv tmp ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt' 


    ## merge each of the 3 replication files to get a merged file per experimental condition
    bcftools merge -Oz -o ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        ${in_vcfs}'/s'$((3*$i+1))'_ERC_VarFilt_DPgt10.vcf.gz' \
        ${in_vcfs}'/s'$((3*$i+2))'_ERC_VarFilt_DPgt10.vcf.gz' \
        ${in_vcfs}'/s'$((3*$i+3))'_ERC_VarFilt_DPgt10.vcf.gz'

    tabix -p vcf ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz'

   ## extract from the vcfs only the needed positions
    bcftools view -Oz -R ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_gt2.txt' \
        ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        -o ${out_merge}'/'${arr_sample_names[$i]}'_merge_gt2.vcf.gz' && tabix -p vcf ${out_merge}'/'${arr_sample_names[$i]}'_merge_gt2.vcf.gz'
   
    bcftools view -Oz -R ${out_txt}'/'${arr_sample_names[$i]}'_gt2/sites_eq3.txt' \
        ${out_merge}'/'${arr_sample_names[$i]}'_merge.vcf.gz' \
        -o ${out_merge}'/'${arr_sample_names[$i]}'_merge_eq3.vcf.gz' && tabix -p vcf ${out_merge}'/'${arr_sample_names[$i]}'_merge_eq3.vcf.gz'
done

t30=$(date +%s)

echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"
