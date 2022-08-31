#!/bin/bash -l
module load samtools

dir_input='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/analysis_bam_default_dive_into_reads/analysis_bam_default_fC-R/featureCounts'
dir_output='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/analysis_bam_default_dive_into_reads'

for k in $(find ${dir_input} -iname '*filtered.bam.featureCounts.bam' -printf '%P\n' | sort -V)
do
    echo 'starting with file:' $k

    echo $k ' - unique reads '
    samtools view -h -f 2 -F 4 -F 256 -F 1024 ${dir_input}/$k | samtools sort -@ 4 -m 50G -o ${dir_output}/unique/$(basename ${k%%.bam*})_unique.bam; samtools index ${dir_output}/unique/$(basename ${k%%.bam*})_unique.bam
############################################
    
    echo $k ' - duplicate reads ' 
#    samtools view -h -f 2 -F 4 -f 1024 ${dir_input}/$k  >>  ${dir_output}/duplicates/$(basename ${k%%.bam*})_duplicates.bam
    samtools view -h -f 2 -F 4 -f 1024 ${dir_input}/$k | samtools sort -@ 4 -m 50G -o ${dir_output}/duplicates/$(basename ${k%%.bam*})_duplicates.bam ; samtools index ${dir_output}/duplicates/$(basename ${k%%.bam*})_duplicates.bam 
##############################################

    echo $k ' - multimapping reads '
#    samtools view -h -f 2 -F 4 -f 256 ${dir_input}/$k >>  ${dir_output}/multimappers/$(basename ${k%%.bam*})_mm.bam
    samtools view -h -f 2 -F 4 -f 256 ${dir_input}/$k | samtools sort -@ 4 -m 50G -o ${dir_output}/multimappers/$(basename ${k%%.bam*})_mm.bam; samtools index ${dir_output}/multimappers/$(basename ${k%%.bam*})_mm.bam
##############################################

    echo $k 'done'
done

echo '**Processing complete!**'


