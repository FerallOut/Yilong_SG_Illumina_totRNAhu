#!/bin/bash -l

## script to count the DHX9 peaks within all genes in the genome 

## load modules
module load bedtools2

## directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/reproducible'
#main_dir=$HOME'/project2218'

in_peaks='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.09_Flash_2218_overlap/ln_data/03aPeakCallingSTARPeakachuRscript'
##in_fastq=${main_dir}'/data_int/bam'

arr_name=(WT UV)

out_dir=${main_dir}'/7_FLASH_data'
#out_dir=${main_dir}'/output/data'

## files, references
ref_gtf='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/references/GRCh38_v27.gtf'
#ref_gtf=${main_dir}'/data_int/references/GRCh38_v27.gtf'

refGene_bed='/data/manke/processing/balan/Yilong_SG_data/run_2218/data_int/references/GRCh38_v27.gene_only.bed'
#ref_bed12=${main_dir}'/data_int/references/GRCh38_v27.gene_only.bed'

## make dir
#mkdir -p ${out_dir}
##########################################################################


## run code
printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
t0=$(date +%s)

## create the gene model by extracting only the gene information from the gtf file
echo "Extract gene coordinates from gtf"
grep -P "\tgene\t" ${ref_gtf} | cut -f1,4,5,7,9 | \
    sed 's/[[:space:]]/\t/g' | sed 's/[;|"]//g' | \
    awk -F $'\t' 'BEGIN { OFS=FS } { print $1,$2-1,$3,$6,".",$4,$10,$12,$14 }' | \
    sort -k1,1 -k2,2n > ${refGene_bed}


## get the intersection of the genes.bed file and DHX9peaks.bed files, while counting the number of peaks per gene
for i in ${!arr_name[@]}
do
    echo "${arr_name[$i]}"
    
    # count
    bedtools intersect -c -s -b ${in_peaks}'/DHX9_'${arr_name[$i]}'/peaks.bed'  -a ${refGene_bed} > ${out_dir}'/1_overlap_DHX9peaks'${arr_name[$i]}'.bed'

    # add header and remove unwanted columns
    cut --complement -f5,8 ${out_dir}'/1_overlap_DHX9peaks'${arr_name[$i]}'.bed' > ${out_dir}'/2_overlap_DHX9peaks'${arr_name[$i]}'_clean.bed'  &&  sed -i '1i chr\tf_start\tf_end\tgene\tstrand\tsymbol\thavana\tcount' ${out_dir}'/2_overlap_DHX9peaks'${arr_name[$i]}'_clean.bed'

    # sort in reverse and output file:
    sort -r -n -k 8 ${out_dir}'/2_overlap_DHX9peaks'${arr_name[$i]}'_clean.bed' > ${out_dir}'/3_overlap_DHX9peaks'${arr_name[$i]}'_cleanSort.bed'
done

t1=$(date +%s)


echo "Script ran for $(date -ud "@$(($t1 - $t0))" +%T) (HH:MM:SS)"
echo "Processing complete at $(date +"%x %r %Z")"

