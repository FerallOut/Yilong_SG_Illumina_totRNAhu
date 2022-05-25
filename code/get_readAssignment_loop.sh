#!/bin/bash -l
module load samtools

file_dir='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/analysis_bam_default_dive_into_reads/analysis_bam_default_fC-R/featureCounts'
out_file=${file_dir}/reads_tags_fC

for k in $(find ${file_dir} -iname '*filtered.bam.featureCounts.bam' -printf '%P\n' |  sort -V )
do
    echo $k >> ${out_file}
    samtools view $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c >> ${out_file}
done



