#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules
module load bcftools

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript/5_SNP_TtoCmutation_analysis'
out_tsvs=${main_dir}'/8c_GATKcorr_ERC_VarFilt_DPgt10/trial2_counts_each_sample'
in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
out_merge=${out_tsvs}'/2_merged_replicates_SNPs'
dir_counts=${out_tsvs}'/3_base_counts'

arr_sample_names=(totRNA_mock totRNA_arsenite totRNA_HS totRNA_NaCl totRNA_UV sgRNA_arsenite sgRNA_HS sgRNA_NaCl sgRNA_UV)

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
gtf_zip=${main_dir}'/5_SNP_TtoCmutation_analysis/9b_annot_vcfs/vep/references/hg38_p27.gtf.gz'
##########################################################################
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

######################################################################3

## extract all the mutations from the files

## create the row names:
bcftools stats ${out_merge}'/totRNA_mock_merge.vcf.gz' | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/' | cut -f 3  | sed -e '1d;2d;$d' | tee ${dir_counts}'/mutations_all.txt' ${dir_counts}'/mutations_gt2.txt' ${dir_counts}'/mutations_eq3.txt'


## SAMPLES WITH ALL MUTATIONS (filtered)
## get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find ${out_merge} -iname "*merge.vcf.gz"| sort -rV); do echo "$(basename ${i%%_merge*})"; bcftools stats $i | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| cut -f 4 | sed -e '1d;2d;$d'| paste ${dir_counts}'/mutations_all.txt' - > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_all.txt' ; done 
## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${dir_counts}'/mutations_all.txt') > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_all.txt' 
## insert 'mutation' as name of col 1
sed "1s/^/mutation\t/" ${dir_counts}'/mutations_all.txt' > tmp4.txt && mv -f tmp4.txt ${dir_counts}'/mutations_all.txt'


## SAMPLES WITH the mutations that appear in all 3 replicates (filtered)
#get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find ${out_merge} -iname "*merge_eq3.vcf.gz"| sort -rV); do echo "$(basename ${i%%_merge*})"; bcftools stats $i | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| cut -f 4 | sed -e '1d;2d;$d'| paste ${dir_counts}'/mutations_eq3.txt' - > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_eq3.txt' ; done  
## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${dir_counts}'/mutations_eq3.txt') > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_eq3.txt' 
## insert 'mutation' as name of col 0
sed "1s/^/mutation\t/" ${dir_counts}'/mutations_eq3.txt' > tmp4.txt && mv -f tmp4.txt ${dir_counts}'/mutations_eq3.txt'


## SAMPLES WITH the mutations that appear in at least 2 replicates (filtered)
## get all mutation counts (in a reversed order!) and paste to the previous file:
for i in $(find ${out_merge} -iname "*merge_gt2.vcf.gz"| sort -rV); do echo "$(basename ${i%%_merge*})"; bcftools stats $i | awk '/# ST, Substitution types:/ ,/# DP, Depth distribution/'| cut -f 4 | sed -e '1d;2d;$d'| paste ${dir_counts}'/mutations_gt2.txt' - > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_gt2.txt' ; done  
## add column names:
## insert sample names as column names
(printf "%s\t" "${arr_sample_names[@]}" | sed -e 's/\t$/\n/' && cat ${dir_counts}'/mutations_gt2.txt') > tmp4.txt  &&  mv -f tmp4.txt ${dir_counts}'/mutations_gt2.txt' 
## insert 'mutation' as name of col 1
sed "1s/^/mutation\t/" ${dir_counts}'/mutations_gt2.txt' > tmp4.txt && mv -f tmp4.txt ${dir_counts}'/mutations_gt2.txt'


t30=$(date +%s)

echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"
