#!/bin/bash -l
#module load bcftools

#echo "Script started at $(date +"%x %r %Z")" 

main_dir='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript'
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
bcftools_call_r='SNP_TtoC_mutation_analysis/bcftools_call_replicates'

#t0=$(date +%s)

#module load bcftools

#for k in $(find ${main_dir}'/bam' -iname 's*.bam' -printf '%P\n' | sort -V)

files=($(find ${main_dir}'/bam' -iname 's*.bam' -printf '%P\n' | sort -V))

#echo ${files[@]}

for ((index=0; index < ${#files[@]}; index+=3))
do
    #echo $(basename ${k%%.bam*})
    #echo "$index"
    #echo "${files[$index]}"
#############################################

    t1=$(date +%s)
    bcftools mpileup  --threads 20 -d 10000 -Ou -f ${ref} \
        ${main_dir}'/bam/'${files[$index]} ${main_dir}'/bam/'${files[$index+1]} ${main_dir}'/bam/'${files[$index+2]} |\
        bcftools call --threads 20 -mv -Ov --skip-variants indels \
        --pval-threshold 0.05 \
        --output ${main_dir}'/'${bcftools_call_r}'/'${files[$index]}_bcftools_calls_repl3.vcf

    t2=$(date +%s)
#    echo "Script ran for $(date -ud "@$(($t3 - $t2))" +%T) (HH:MM:SS)"   
##########################################

done
#t3=$(date +%s)

#echo "Script ran for $(date -ud "@$(($t3 - $t0))" +%T) (HH:MM:SS)"
#echo '**Processing complete!**'

