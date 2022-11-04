#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules
module load gatk4

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript/5_SNP_TtoCmutation_analysis'
in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
HC_ERC_genoGVCFs=${main_dir}'/8b_GATKcorr_ERC_GenoGVCFs'
HC_ERC_VarFilt=${main_dir}'/8c_GATKcorr_ERC_VarFilt_DPgt10'

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
##########################################################################
##################################################################

t0=$(date +%s)

#printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

echo "extraction of positions only with DP >=10"  

#for k in $(find ${in_bam} -iname '*.bam' | sort -V)
for k in $(find ${in_bam} -iname 's*.bam'| sort -V)
do 
    echo $(basename ${k%%.bam*})
    t1=$(date +%s) 
    gatk SelectVariants -R ${ref} -V ${HC_ERC_genoGVCFs}'/'$(basename ${k%%.bam*})'_ERC_genoGVCFs.vcf.gz' \
        -O ${HC_ERC_VarFilt}'/'$(basename ${k%%.bam*})'_ERC_VarFilt_DPgt10.vcf.gz' \
        -select "DP>=10" \
        2>${HC_ERC_VarFilt}'/log/'$(basename ${k%%.bam*})'_ERC_VarFilt_DPgt10.log'
    t2=$(date +%s) 
    echo "$(date -ud "@$(($t2 - $t1))" +%T)" 
done


t30=$(date +%s)


echo "Processing complete at $(date +"%x %r %Z")"
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"


