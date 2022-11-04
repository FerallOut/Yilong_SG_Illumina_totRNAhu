#!/bin/bash -l
module load bcftools

echo "Script started at $(date +"%x %r %Z")" 

main_dir='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript'
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
bcftools_call='SNP_TtoC_mutation_analysis/bcftools_call'

t0=$(date +%s)

module load bcftools

#for k in $(find ${main_dir}'/bam' -iname 's*.bam' -printf '%P\n' | sort -V)
for k in $(find ${main_dir}'/bam' -iname 's*.bam' -and '!' -iname 's[1,3-9,10-19]*' -printf '%P\n' | sort -V)

do
    echo $k
    #echo $(basename ${k%%.bam*})
#############################################

# Options -B and -E can't be combined    

    t1=$(date +%s)
    bcftools mpileup  --threads 20 -d 10000 -Ou -f ${ref} \
        ${main_dir}'/bam/'${k} |\
        bcftools call --threads 20 -mv -Ov --skip-variants indels \
        --pval-threshold 0.05 \
        --output ${main_dir}'/'${bcftools_call}'/'$(basename ${k%%.bam*})_bcftools_calls.vcf

    t2=$(date +%s)
    echo "Script ran for $(date -ud "@$(($t3 - $t2))" +%T) (HH:MM:SS)"   
##########################################

done
t3=$(date +%s)

echo "Script ran for $(date -ud "@$(($t3 - $t0))" +%T) (HH:MM:SS)"
echo '**Processing complete!**'

