#!/bin/bash -l
module load snakePipes

for k in $(find . -maxdepth 1 -name 'sgRNA_*' -printf '%P\n')
do
    mRNA-seq -i /data/processing1/bioinfo_core/requests/FANCI_RNA_seq_4stresses/bam/ \
    -o /data/processing1/bioinfo_core/requests/FANCI_RNA_seq_4stresses/analysis_bam_default/ \
    -v -j 20 --DAG --emailAddress balan@ie-freiburg.mpg.de --smtpServer mail.ie-freiburg.mpg.de \
    --emailSender balan@ie-freiburg.mpg.de \
    --sampleSheet ${k} --fromBAM --rMats hg38
done


