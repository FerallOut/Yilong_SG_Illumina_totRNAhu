#!/bin/bash -l
module load samtools

dir_file='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/analysis_bam_default_dive_into_reads/analysis_bam_default_fC-R/featureCounts'

for k in $(find ${dir_file} -iname 's*.filtered.bam.featureCounts.bam' -printf '%P\n' | sort -V)
do
    echo $k
#############################################
    samtools view -H $k > header.sam

    samtools view -h $k | grep 'XS:Z:Unassigned_NoFeatures' | cat header.sam - | samtools view -Sb -f 0x400 -o $(basename ${k%%.bam*})_NoFeatures.bam -
  
 
done
 
echo '**Processing complete!**'


