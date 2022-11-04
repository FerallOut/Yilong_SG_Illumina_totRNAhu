#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript/5_SNP_TtoCmutation_analysis'
#in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
in_vcf1=${main_dir}'/7b_bam_RG_merge_GATKcorr_HC_vcfs'
in_vcf2=${main_dir}'/7b_bam_RG_merge_GATKcorr_HC_vcfs_QD2.0_FS60.0_MQ_40.0_HS_13.0_MQRS12.5'
in_vcf3=${main_dir}'/8b_bam_RG_merge_GATKcorr_HC_vcfs_QD2.0_FS60.0_MQ_40.0_HS_13.0_MQRS12.5_TtoC'

out_vep=${main_dir}'/12b_VEP_COMPARE'

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
gtf_zip=${main_dir}'/9b_annot_vcfs/vep/references/hg38_p27.gtf.gz'
##########################################################################
##################################################################

t0=$(date +%s)

#printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

echo "VEP annotation of the SNPs:"  

for i in $(find ${in_vcf1} -iname '*_GATKCorr_SNPs.vcf.gz' | sort -V)
do 
    echo "$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})"

    vep -i ${in_vcf1}'/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_GATKCorr_SNPs.vcf.gz' \
        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
        -o ${out_vep}'/all_NoFilt/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_vep.tab' --species "homo_sapiens" \
        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_vep.log' \
        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 

#    vep -i ${in_vcf1}'/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_GATKCorr_SNPs_TtoC.vcf.gz' \
#        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
#        -o ${out_vep}'/all_NoFilt_TtoC/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_TtoC_vep.tab' --species "homo_sapiens" \
#        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_TtoC_vep.log' \
#        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
#        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 
#######################

#    vep -i ${in_vcf2}'/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_GATKCorr_SNPs_filtPASS.vcf.gz' \
#        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
#        -o ${out_vep}'/all_Filt_NoMerge/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_Filt_vep.tab' --species "homo_sapiens" \
#        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_Filt_vep.log' \
#        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
#        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 


#    vep -i ${in_vcf3}'/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_GATKCorr_SNPs_filtPASS_TtoC.vcf.gz' \
#        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
#        -o ${out_vep}'/all_Filt_NoMerge_TtoC/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_Filt_TtoC_vep.tab' --species "homo_sapiens" \
#        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${i%%_GATKCorr_SNPs.vcf.gz*})'_allSNP_Filt_TtoC_vep.log' \
#        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
#        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 
#######################



done


t30=$(date +%s)


echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"

