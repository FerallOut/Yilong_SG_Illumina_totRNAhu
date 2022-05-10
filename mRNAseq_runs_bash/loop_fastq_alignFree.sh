#!/bin/bash -l
module load snakePipes

for k in $(find . -maxdepth 1 -name 'sgRNA_*' -printf '%P\n')
do
    mRNA-seq -i /data/processing1/bioinfo_core/requests/FANCI_RNA_seq_4stresses/fastq/ \
    -o /data/processing1/bioinfo_core/requests/FANCI_RNA_seq_4stresses/analysis_fastq_free_trim_gtffilter/ \
    -v -j 20 --DAG --emailAddress balan@ie-freiburg.mpg.de --smtpServer mail.ie-freiburg.mpg.de \
    --emailSender balan@ie-freiburg.mpg.de --trim -m alignment-free,deepTools_qc \
    --filterGTF='-v pseudogene' --sampleSheet ${k} --rMats hg38
done

