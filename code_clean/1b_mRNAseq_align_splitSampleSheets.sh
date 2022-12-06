#!/bin/bash -l

## script to run mRNAseq snakePipes starting from bam files, with multiple sample sheets

## directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

#in_bam=$1'/data_int/bam'
{ read -r bams; } < <(yq -y '.paths."bam_files"' sources.yaml)
in_bam=${main_dir}${bams}

#out_dir=$1'/output/1b_mRNAseq_alignment_splitSampleSheets'
{ read -r out_bams; } < <(yq -y '.paths."1b_mRNA-seq"' sources.yaml)
out_dir=${main_dir}${out_bams}

# files, references
#sampSheet_dir=$1'/data_int/sampleSheets/sampleSheets_sgRNA_split'
{ read -r sampSheet_dir; } < <(yq -y '.paths."sgRNA_split_smplSheet_dir"' sources.yaml)
sgRNA_sampSheet_dir=${main_dir}${sampSheet_dir}
##########################################################################

## run code

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

# these sample sheets are split to contain only 2 experimental conditions
for k in $(find ${sgRNA_sampSheet_dir} -maxdepth 1 -name 'batch_sgRNA_*.tsv' -printf '%P\n')
do
    echo "* Run mRNAseq pipeline with sample sheet:" ${k}  
    t1=$(date +%s)
    
    mRNA-seq -i ${in_bam} -o ${out_dir} \
        -v -j 20 --DAG --sampleSheet ${sampSheet_dir}'/'${k} --fromBAM hg38

    t2=$(date +%s)
    echo ${k}"** Sample sheet ran for $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"
done

t4=$(date +%s)

echo "Script ran for $(date -ud "@$(($t4 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

