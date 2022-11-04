#!/bin/bash -l

# load needed modules
module load bcftools

# load needed paths and folders
main_dir='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript'
input_dir='SNP_TtoC_mutation_analysis/5a_bam_RG_merge_manCorr_NM'
bcftools_extract_01='SNP_TtoC_mutation_analysis/bcftools_extract_mut01'
bcftools_call_01='SNP_TtoC_mutation_analysis/bcftools_call_mut01'

ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
gene='/data/repository/organisms/GRCh38_ensembl/gencode/release_27/genes.bed'

echo "Script started at $(date +"%x %r %Z")" 
t0=$(date +%s)


 for k in $(find ${main_dir}'/'${input_dir} -iname 's*.bam' -printf '%P\n' | sort -V)
#for k in $(find ${main_dir}'/'${input_dir} -iname '[s][1][0-9]{1}.bam' -and -iname '[s][2][0-9]{1}.bam' -printf '%P\n' | sort -V) 
do
    echo $k
    #echo $(basename ${k%%_*})
#############################################

#  ### Step A: Add the NM tag to the reads in the bam file, either manually or with GATK Split'N'Trim

#  ### Step B: Extract all the reads from each bam file that has either no or max 1 mutation/ error, using the NM tag (NOT the nM tag!)     

#    t1=$(date +%s)

#    (samtools view -H ${main_dir}'/'${input_dir}'/'${k}; samtools view -@ 20 ${main_dir}'/'${input_dir}'/'${k} | grep -w 'NM:i:1\|NM:i:0') | samtools view -@ 20 -bS - > ${main_dir}'/'${bcftools_extract_01}'/'$(basename ${k%%_*})'_reads_01NM.bam'

    t2=$(date +%s)
#    echo "Extraction took $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"   
#############################################
   
#   ### Step C: run bcftools mpileup to call mutations on the extracted reads 
    bcftools mpileup  --threads 20 -d 10000 -Ou -f ${ref} \
        ${main_dir}'/'${bcftools_extract_01}'/'$(basename ${k%%_*})'_reads_01NM.bam' |\
        bcftools call --threads 20 -m -Ov --skip-variants indels \
        --pval-threshold 0.05 \
        --output ${main_dir}'/'${bcftools_call_01}'/'$(basename ${k%%_*})'_reads_01NM_bcftools_calls_all.vcf'
    t3=$(date +%s)

    echo "Mutation caller ran for $(date -ud "@$(($t3 - $t2))" +%T) (HH:MM:SS)"   
##########################################

done
t4=$(date +%s)

echo "Script ran for $(date -ud "@$(($t4 - $t0))" +%T) (HH:MM:SS)"
echo '**Processing complete!**'

