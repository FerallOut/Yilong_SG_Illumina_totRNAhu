#!/bin/bash


# extract the mutations you are interested in, calculate the frequency of the ALT allele and then insert it in the 8th column in the vcf file

main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript/5_SNP_TtoCmutation_analysis'
in_filt_dir=${main_dir}'/7b_bam_RG_merge_GATKcorr_HC_vcfs/1_forIGV_COMP2/2_merged'
out_dir=${main_dir}'/7b_bam_RG_merge_GATKcorr_HC_vcfs/1_forIGV_COMP2/9_IGV_allmerged'

# retain only the T to C mutations (on col 4 and 5), filtering out all the others:
echo 'Retain only TtoC mutations'

for k in $(find ${in_filt_dir} -maxdepth 1 -iname '*_merge.vcf.gz' | sort -V); do 
    echo $(basename ${k%%.vcf.gz})
    zcat $k | awk '/#/ || ($4=="T" && $5=="C")' | bgzip -@ 20 > ${out_dir}'/'$(basename ${k%%.vcf.gz})_TtoC.vcf.gz
    tabix -p vcf ${out_dir}'/'$(basename ${k%%.vcf.gz})_TtoC.vcf.gz 
    #mv $(basename ${k%%.vcf.gz})_TtoC.vcf.gz ${out_dir}
done


# replace the 8th column (INFO) with only the AF=(calculated frequency)
echo 'Calculate the frequency of the ALT allele'

for k in $(find ${out_dir} -maxdepth 1 -iname '*_TtoC.vcf.gz' | sort -V); do 
    echo $(basename ${k%%.vcf.gz})
    # to create the new files, extract full header
    zcat $k | awk '/#/' > ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf
    
    # calculate ALT allele frequency, print rows (without header) in correct order; append to header
    paste <( zcat $k | awk -F '\t' '/^[^#]/{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7}') \
        <( zcat $k | awk -F ":" 'BEGIN {OFS=FS=":"} {$6=="." || $10=="." || $14=="."}; function GSUB(F) {gsub(/\./,"0,0",$F)}; {GSUB(6) GSUB(10) GSUB(14)}1' | LC_NUMERIC=en_US.UTF-8 awk -F ":" 'function SPLIT(G) {split($G,a,","); {b=((a[1]+a[2]==0) ? 0: a[2]/(a[1]+a[2]))}; return b}; /^[^#]/{c=(SPLIT(6)+SPLIT(10)+SPLIT(14))/3; print "AF="c}' ) \
        <( zcat $k | awk -F '\t' '/^[^#]/{print $9"\t"$10"\t"$11"\t"$12}')  >> ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf
    bgzip -@ 20 ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf
    tabix -p vcf ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf.gz
done

echo 'script done'
