#!/bin/bash -l

## script to run mRNAseq snakePipes starting from bam files, with multiple sample sheets

## load modules
module load snakePipes

## directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/reproducible'
#main_dir=$HOME'/project2218'

in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
#in_bam=${main_dir}'/data_int/bam'

out_dir=${main_dir}'/1_mRNAseq_output_alignment'
#out_dir=${main_dir}'/output/1_mRNAseq_output_alignment'

# files, references
sampSheet_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/sampleSheets/new_ss/'
#sampSheet_dir=${out_dir}'/data_int/splitSampleSheets'


## make dir
#mkdir -p ${main_dir} ${out_dir}
##########################################################################

## run code

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

for k in $(find ${sampSheet_dir} -maxdepth 1 -name 'sgRNA_*' -printf '%P\n')
do
    echo "* Run mRNAseq pipeline with sample sheet" ${k}  
    t1=$(date +%s)
    
    mRNA-seq -i ${in_bam} -o ${out_dir} \
        -v -j 20 --DAG --sampleSheet ${k} --fromBAM hg38

    t2=$(date +%s)
    echo ${k}"** Sample sheet ran for $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"
done

t4=$(date +%s)

echo "Script ran for $(date -ud "@$(($t4 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

