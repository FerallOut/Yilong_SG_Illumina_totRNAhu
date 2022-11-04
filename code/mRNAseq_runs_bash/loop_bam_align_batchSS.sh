#!/bin/bash -l
module load snakePipes

for k in $(find /data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/sampleSheets/new_ss -iname 'batch_*' -printf '%P\n')
do
    mRNA-seq -i /data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/bam/ \
    -o /data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/analysis_bam_default_fC-R/ \
    -v -j 20 --DAG --emailAddress balan@ie-freiburg.mpg.de --smtpServer mail.ie-freiburg.mpg.de \
    --emailSender balan@ie-freiburg.mpg.de --featureCountsOption '-R BAM' \
    --fromBAM  hg38
done


