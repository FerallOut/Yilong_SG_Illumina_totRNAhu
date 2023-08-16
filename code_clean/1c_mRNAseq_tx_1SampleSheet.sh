#!/bin/bash -l

## script to run mRNAseq snakePipes starting from bam files, with one sample sheet

## load modules
module load snakePipes

## directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

#in_fastq=$1'/data_int/fastq'
{ read -r fastqs; } < <(yq -y '.paths."fastq_files"' sources.yaml)
in_fastq=${main_dir}${fastqs}


#out_dir=$1'/output/1c_mRNAseq_tx_1SampleSheet'
{ read -r out_bams; } < <(yq -y '.paths."1c_mRNA-seq"' sources.yaml)
out_dir=${main_dir}${out_bams}

# files, references
#sampSheet=$1'/data_int/sampleSheets/batch_totalRNA_corrected_sampleSheet.tsv'
{ read -r sampSheet; } < <(yq -y '.paths."totRNA_smplSheet"' sources.yaml)
sampSheet=${main_dir}${sampSheet}
##########################################################################

## run code

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

echo "* Run mRNAseq pipeline with sample sheet:" $(basename ${sampSheet}) 

mRNA-seq -i ${in_fastq} -o ${out_dir} \
    -v -j 20 --DAG --sampleSheet ${sampSheet} \
    --trim -m alignment-free,deepTools_qc --rMats hg38

t1=$(date +%s)

echo "Script ran for $(date -ud "@$(($t1 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

