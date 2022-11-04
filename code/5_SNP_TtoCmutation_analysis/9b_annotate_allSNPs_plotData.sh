#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules
module load samtools picard-tools gatk4

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript'
in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
in_vcf=${main_dir}'/5_SNP_TtoCmutation_analysis/7b_bam_RG_merge_GATKcorr_HC_vcfs'
out_vep=${main_dir}'/5_SNP_TtoCmutation_analysis/9b_annot_vcfs/vep/out_files_vep_all'

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
gtf_zip=${main_dir}'/5_SNP_TtoCmutation_analysis/9b_annot_vcfs/vep/references/hg38_p27.gtf.gz'
##########################################################################
##################################################################

t0=$(date +%s)

#printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

echo "VEP annotation of the SNPs:"  

for k in $(find ${in_bam} -iname '*.bam' | sort -V)
do 
    echo $(basename ${k%%.bam*})

    vep -i ${in_vcf}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs.vcf.gz' \
        --gtf ${gtf_zip} --fasta ${ref} --fork 4 \
        -o ${out_vep}'/'$(basename ${k%%.bam*})'_SNPvep_all_fields.tab' --species "homo_sapiens" \
        --force_overwrite --warning_file ${out_vep}'/log/'$(basename ${k%%.bam*})'_SNPvep_all_fields.log' \
        --tab --variant_class --regulatory --total_length --numbers --hgvs --hgvsg --symbol --ccds --biotype \
        --fields "Location,Allele,Gene,Feature,Feature_type,Consequence,Codons,IMPACT,STRAND,VARIANT_CLASS,SYMBOL,BIOTYPE_CANONICAL,EXON,INTRON" 
done


t30=$(date +%s)


echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"


