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
call_HC_GATKcorr=${main_dir}'/5_SNP_TtoCmutation_analysis/7b_bam_RG_merge_GATKcorr_HC_vcfs'
ins_HC_GATKcorr=${main_dir}'/5_SNP_TtoCmutation_analysis/7b_bam_RG_merge_GATKcorr_HC_vcfs_plotValues'

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
##########################################################################
##################################################################

t0=$(date +%s)

#printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

echo "SNPs extraction with VariantFiltration"  

for k in $(find ${in_bam} -iname '*.bam' | sort -V)
do 
    echo $(basename ${k%%.bam*})
    gatk VariantsToTable -R ${ref} -V ${call_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs.vcf.gz' \
        -F CHROM -F POS -F QUAL -F QD -F DP -F MQ -F MQRankSum -F FS -F ReadPosRankSum -F SOR \
        -GF AD -GF DP -GF GQ \
        -O ${ins_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_VarToTable.tab' \
        2>${ins_HC_GATKcorr}'/log/'$(basename ${k%%.bam*})'_VarToTable.log'
done


t30=$(date +%s)


echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"


