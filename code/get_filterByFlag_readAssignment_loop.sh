#!/bin/bash -l
module load samtools

dir_file='/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript/analysis_bam_default_dive_into_reads/analysis_bam_default_fC-R/featureCounts'
out_file=${dir_file}/reads_tags_fC_flags

for k in $(find ${dir_file} -iname '*filtered.bam.featureCounts.bam' -printf '%P\n' | sort -V)
do
    echo 'starting with file:' $k

    #echo $k >> ${out_file}
    #samtools view $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c >> ${out_file}
    #samtools view $k | grep 'XS:Z:Assigned' | head | cut -f 2 | sort | uniq -c >> ${out_file}

    echo $k ' - unique reads: ' | tee >> ${out_file}  # print to stdout and file
    samtools view -c -f 2 -F 4 -F 256 -F 1024 $k  >> ${out_file}
    
    echo $k ' - Assignment of unique reads: ' | tee >> ${out_file}
    samtools view -f 2 -F 4 -F 256 -F 1024 $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c >> ${out_file}

##############################################
    
    echo $k ' - duplicate reads: ' | tee >> ${out_file}  # print to stdout and file
    samtools view -c -F 4 -f 1024 $k  >> ${out_file}

    echo $k ' - Assignment of duplicate reads: ' | tee >> ${out_file}
    samtools view -F 4 -f 1024 $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c >> ${out_file}

##############################################

    echo $k ' - multimapping reads: ' | tee >> ${out_file}  # print to stdout and file
    samtools view -c -F 4 -f 256 $k >> ${out_file}

    echo $k ' - Assignment of multimapping reads: ' | tee >> ${out_file}
    samtools view -F 4 -f 256 $k | grep -oh '\w*XS:Z:\w*' | cut -d ':' -f 3 | sort | uniq -c >> ${out_file}

##############################################

    echo $k 'done'
done

echo '**Processing complete!**'


