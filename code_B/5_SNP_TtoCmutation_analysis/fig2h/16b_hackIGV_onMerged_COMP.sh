#!/bin/bash


# extract the mutations you are interested in, calculate the frequency of the ALT allele and then insert it in the 8th column in the vcf file

main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript/5_SNP_TtoCmutation_analysis'
in_filt_dir=${main_dir}'/8b_bam_RG_merge_GATKcorr_HC_vcfs_QD2.0_FS60.0_MQ_40.0_HS_13.0_MQRS12.5_TtoC/1_forIGV_COMP/2_merged'
out_dir=${main_dir}'/8b_bam_RG_merge_GATKcorr_HC_vcfs_QD2.0_FS60.0_MQ_40.0_HS_13.0_MQRS12.5_TtoC/1_forIGV_COMP/4_IGV'

# retain only the T to C mutations (on col 4 and 5), filtering out all the others:
#echo 'Retain only TtoC mutations'

#for k in $(find ${in_filt_dir} -iname '*_eq3.vcf.gz' | sort -V); do 
#    echo $(basename ${k%%.vcf.gz})
#    zcat $k | awk '/#/ || ($4=="T" && $5=="C")' | bgzip -@ 20 > ${out_dir}'/'$(basename ${k%%.vcf.gz})_TtoC.vcf.gz
#    tabix -p vcf ${out_dir}'/'$(basename ${k%%.vcf.gz})_TtoC.vcf.gz 
    #mv $(basename ${k%%.vcf.gz})_TtoC.vcf.gz ${out_dir}
#done


# replace the 8th column (INFO) with only the AF=(calculated frequency)
echo 'Calculate the frequency of the ALT allele'

for k in $(find ${in_filt_dir} -iname '*_merge_eq3.vcf.gz' | sort -V); do 
    echo $(basename ${k%%.vcf.gz})
    # to create the new files, extract full header
    zcat $k | awk '/#/' > ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf

    #calculate ALT allele frequency, print rows (without header) in correct order; append to header
    paste <( zcat $k | awk -F '\t' '/^[^#]/{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7}') \
        <( zcat $k | LC_NUMERIC=en_US.UTF-8 awk -F ":|," '/^[^#]/{print "AF="( ($7/($6+$7) + $14/($13+$14)) + $21/($20+$21) )/3 }') \
        <( zcat $k | awk -F '\t' '/^[^#]/{print $9"\t"$10"\t"$11"\t"$12}') >> ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf


    echo 'index'
    bgzip -@ 20 ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf
    tabix -p vcf ${out_dir}'/'$(basename ${k%%.vcf.gz})_1AF.vcf.gz
done

echo 'script done'
