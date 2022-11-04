#!/bin/bash -l

## script to run kraken on fastq files to check for any sources of contamination 
## the fastq files are saved in pairs in different folders, e.g.:
## folderA/sampleN_R1.fastq.gz	folderA/sampleN_R2.fastq.gz
## folderB/sampleM_R1.fastq.gz	folderB/sampleM_R2.fastq.gz 	etc


## load modules
#conda init /localenv/pipegrp/anaconda/miniconda3/envs/dissectBCL
module load MultiQC

## directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/reproducible'
#main_dir=$HOME'/project2218'

in_fastq='/data/akhtar/sequencing_data4/220310_A00931_0420_AH7M2JDMXY_lanes1_2/Project_2218_Zhou_Akhtar/Sample_*/'
#in_fastq=${main_dir}'/data_int/fastq'

out_dir=${main_dir}'/2_qc/1_krakenB'
#out_dir=${main_dir}'/output/2_qc/1_kraken_out'

html_dir=${main_dir}'/2_qc/2_kraken_MQC'
#html_dir=${main_dir}'/output/2_qc/2_kraken_MQC'

# files, references
kraken_db='/data/repository/kraken2_contaminome/contaminomedb'
threads=4

## make dir
#mkdir -p ${out_dir}
##########################################################################

## run code
## run kraken to get the data

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

for k in $(find ${in_fastq} -type d)
do
    f=$k*R1.fastq*
    g=$(basename ${f%%*.gz})
    #echo $g
    
    echo "* Run kraken on the pair of fastq files: " $(basename ${g%%_*})
    t1=$(date +%s)
    
    kraken2 --db ${kraken_db} --out - --threads ${threads} --paired --report ${out_dir}'/'$(basename ${g%%_*}).rep $k*_R1.fastq.gz $k*_R2.fastq.gz

    t2=$(date +%s)
    echo "** For fastq pair " $(basename ${g%%_*}) ", kraken ran for $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"
done

## run MultiQC to get the html report
echo "* Run Multiqc on the kraken reports to get the html report"
multiqc -o ${html_dir} ${out_dir}


t4=$(date +%s)


echo "Script ran for $(date -ud "@$(($t4 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

