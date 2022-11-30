#!/bin/bash -l

## script to run RSeQC on bam files to check various control parameters 

## load modules
module load UCSCtools RSeQC MultiQC

## directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

{ read -r bams; } < <(yq -y '.paths."bam_files"' sources.yaml)
in_bam=${main_dir}${bams}  

{ read -r RSeQC; } < <(yq -y '.paths."3_qc_RSeQC"' sources.yaml) 
out_dir=${main_dir}${RSeQC}

{ read -r RSeQC_MQ; } < <(yq -y '.paths."3_qc_RSeQC_multiQC"' sources.yaml)  
html_dir=${main_dir}${RSeQC_MQ} 

## references
{ read -r gtf; } < <(yq -y '.paths."gtf_v27"' sources.yaml)
ref_gtf=${main_dir}${gtf}

{ read -r bed; } < <(yq -y '.paths."bed_v27"' sources.yaml)
ref_bed12=${main_dir}${bed}
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

