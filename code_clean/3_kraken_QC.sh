#!/bin/bash -l

## script to run kraken on fastq files to check for any sources of contamination 

## load modules

## directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

{ read -r fastqs; } < <(yq -y '.paths."fastq_files"' sources.yaml)
in_fastq=${main_dir}${fastqs}

{ read -r kraken; } < <(yq -y '.paths."3_qc_kraken"' sources.yaml)
out_dir=${main_dir}${kraken}

{ read -r krakenQC; } < <(yq -y '.paths."3_qc_kraken_multiQC"' sources.yaml)
html_dir=${main_dir}${krakenQC}

# files, references
{ read -r db; } < <(yq -y '.paths."kraken_db"' sources.yaml)
kraken_db=${main_dir}${db}

threads=4
##########################################################################

## run kraken to get the data

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

for k in $(find ${in_fastq} -type f -iname '*fastq.gz' | xargs -I% basename % | cut -d '_' -f 1 | sort -V | uniq)
do
    echo "* Run kraken on the pair of fastq files: " $k
    t1=$(date +%s)
    
    kraken2 --db ${kraken_db} --out - --threads ${threads} --paired \
        --report ${out_dir}'/'$k'.rep' ${in_fastq}'/'$k'_R1.fastq.gz' ${in_fastq}'/'$k'_R2.fastq.gz'

    t2=$(date +%s)
    echo "** For fastq pair " $k ", kraken ran for $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"
done

## run MultiQC to get the html report
echo "* Run Multiqc on the kraken reports to get the html report"
multiqc -o ${html_dir} ${out_dir}


t4=$(date +%s)


echo "Script ran for $(date -ud "@$(($t4 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

