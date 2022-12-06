#!/bin/bash -l

## script to run mRNAseq snakePipes starting from bam files, with one sample sheet

## directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

{ read -r bams; } < <(yq -y '.paths."bam_files"' sources.yaml)
in_bam=${main_dir}${bams}

{ read -r out_bams; } < <(yq -y '.paths."1a_mRNA-seq"' sources.yaml)
out_dir=${main_dir}${out_bams}

# files, references
{ read -r sampSheet; } < <(yq -y '.paths."totRNA_smplSheet"' sources.yaml)
sampSheet=${main_dir}${sampSheet}
##########################################################################

## run code

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

echo "* Run mRNAseq pipeline with sample sheet:" $(basename ${sampSheet}) 

mRNA-seq -i ${in_bam} -o ${out_dir} \
    -v -j 20 --DAG --sampleSheet ${sampSheet} --fromBAM hg38

t1=$(date +%s)

echo "Script ran for $(date -ud "@$(($t1 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

