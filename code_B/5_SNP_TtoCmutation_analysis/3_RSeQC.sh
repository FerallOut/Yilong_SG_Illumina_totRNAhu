#!/bin/bash -l

## script to run RSeQC on bam files to check various control parameters 

## load modules
#conda init /localenv/pipegrp/anaconda/miniconda3/envs/dissectBCL
module load UCSCtools RSeQC

## directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/reproducible'
#main_dir=$HOME'/project2218'

in_bam='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/bam'
#in_fastq=${main_dir}'/data_int/bam'

out_dir=${main_dir}'/2_qc/3_RSeQC'
#out_dir=${main_dir}'/output/2_qc/3_RSeQC'

html_dir=${main_dir}'/2_qc/3_RSeQC_multiqc_data'
#html_dir=${main_dir}'/output/2_qc/3_RSeQC_multiqc_data'

## files, references
ref_gtf='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/references/GRCh38_v27.gtf'
#ref_gtf=${main_dir}'/data_int/references/GRCh38_v27.gtf'

ref_bed12='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/references/GRCh38_v27_UCSC.bed12'
#ref_bed12=${main_dir}'/data_int/references/GRCh38_v27_UCSC.bed12'

## make dir
#mkdir -p ${out_dir}
##########################################################################


## run code
printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

## create the gene model by converting the gtf to bed12 format
echo "Convert the gtf to bed12 format"
gtfToGenePred ${ref_gtf} UCSC.pred 
genePredToBed UCSC.pred ${ref_bed12} && rm UCSC.pred

# run RSeQC on each of the bam files to get the data for read distribution
for k in $(find ${in_bam} -iname '*.bam' | sort -V)
do
    
    echo "* Run RSeQC on " $(basename ${k})
    t1=$(date +%s)
    
    read_distribution.py -i ${k} -r ${ref_bed12} > ${out_dir}'/'$(basename ${k%%.bam}).tab

 
    t2=$(date +%s)
    echo "** For " $(basename ${k}) ", RSeQC ran for $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"
done

## run MultiQC to get the html report
echo "* Run Multiqc on the RSeQC reports to get the html report"
multiqc -o ${html_dir} ${out_dir}


t4=$(date +%s)


echo "Script ran for $(date -ud "@$(($t4 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

