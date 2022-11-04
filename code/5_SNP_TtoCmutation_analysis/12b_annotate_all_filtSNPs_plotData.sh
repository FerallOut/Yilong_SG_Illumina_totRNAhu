#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript/5_SNP_TtoCmutation_analysis'
#in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
in_vcf=${main_dir}'/10b_plots_mutations/3_merged_replicates_SNPs'
out_vep=${main_dir}'/10b_plots_mutations/5_merged_replicates_SNPs_VEP'

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
gtf_zip=${main_dir}'/9b_annot_vcfs/vep/references/hg38_p27.gtf.gz'
##########################################################################
##################################################################

t0=$(date +%s)

#printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

echo "VEP annotation of the SNPs:"  

for i in $(find ${in_vcf} -iname '*_merge.vcf.gz' | sort -V)
do 
    echo "$(basename ${i%%.vcf.gz*})"

    vep -i ${in_vcf}'/'$(basename ${i%%.vcf.gz*})'.vcf.gz' \
        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
        -o ${out_vep}'/'$(basename ${i%%.vcf.gz*})'_allFiltSNP_vep.tab' --species "homo_sapiens" \
        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${i%%.vcf.gz*})'_allFiltSNP_vep.log' \
        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 

    vep -i ${in_vcf}'/'$(basename ${i%%.vcf.gz*})'_eq3.vcf.gz' \
        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
        -o ${out_vep}'/'$(basename ${i%%.vcf.gz*})'_eq3_allFiltSNP_vep.tab' --species "homo_sapiens" \
        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${i%%.vcf.gz*})'_eq3_allFiltSNP_vep.log' \
        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 

    vep -i ${in_vcf}'/'$(basename ${i%%.vcf.gz*})'_gt2.vcf.gz' \
        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
        -o ${out_vep}'/'$(basename ${i%%.vcf.gz*})'_gt2_allFiltSNP_vep.tab' --species "homo_sapiens" \
        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${i%%.vcf.gz*})'_gt2_allFiltSNP_vep.log' \
        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 

done


t30=$(date +%s)


echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"

