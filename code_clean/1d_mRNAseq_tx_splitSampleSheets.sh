#!/bin/bash -l

## script to run mRNAseq snakePipes starting from bam files, with multiple sample sheets

## load modules
module load snakePipes

## directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

#in_fastq=$1'/data_int/fastq'
{ read -r fastqs; } < <(yq -y '.paths."fastq_files"' sources.yaml)
in_fastq=${main_dir}${fastqs}

#out_dir=$1'/output/1d_mRNAseq_tx_splitSampleSheets'
{ read -r out_dir1d; } < <(yq -y '.paths."1d_mRNA-seq"' sources.yaml)
out_dir=${main_dir}${out_dir1d}

# files, references
#sampSheet_dir=$1'/data_int/sampleSheets/sampleSheets_sgRNA_split'
{ read -r sampSH; } < <(yq -y '.paths."sgRNA_split_smplSheet_dir"' sources.yaml)
sampSheet_dir=${main_dir}${sampSH}
##########################################################################

## run code

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

# these sample sheets are split to contain only 2 experimental conditions
for k in $(find ${sampSheet_dir} -maxdepth 1 -name 'batch_sgRNA_*.tsv' -printf '%P\n')
do
    echo "* Run mRNAseq pipeline with sample sheet:" ${k}  
    t1=$(date +%s)
    
    mRNA-seq -i ${in_fastq} -o ${out_dir} \
        -v -j 20 --DAG --sampleSheet ${sampSheet_dir}'/'${k} \
        --trim -m alignment-free,deepTools_qc --rMats hg38

    t2=$(date +%s)
    echo ${k}"** Sample sheet ran for $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"
done

t4=$(date +%s)

echo "Script ran for $(date -ud "@$(($t4 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

