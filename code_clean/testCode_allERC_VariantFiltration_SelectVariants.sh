#!/bin/bash -l

# load modules
module load samtools picard-tools gatk4

# directories
main_dir='/data/manke/group/balan/projects/Yilong_SG_Illumina_totRNAhu'

in_HC_all=${main_dir}'/output/5_SNP_TtoCmut/6_SNP/testAll_VF_SV'
out_all=${main_dir}'/output/5_SNP_TtoCmut/6_SNP/testAll_VF_SV'

# files, references
ref=${main_dir}'/data_int/references/GRCh38_genome.fa'
#########################################################################
comp_all=${out_all}'/comp_all.txt'
##################################################################

rm ${comp_all}

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

t19=$(date +%s)

echo "A. Soft SNPs extraction - create files"

echo "### A.1) with_exclude_BIAL_without_miss_SNP"
echo "### ** VF_complexShort_DP10, SV_exclude_BIAL"
################################
#
#echo "### A.2) with_exclude_BIAL_miss_without_all"
#echo "### ** VF_complexShort_DP10, SV, expand"
#gatk VariantFiltration -R ${ref} -V ${in_HC_all}'/s21_smallTest.vcf.gz'  \
#    -O ${out_all}'/s21_all_2_VFcomplexShortDP_miss.vcf.gz' \
#    --filter-expression "QD<2.0 || FS>60.0 || MQ<40.0 || SOR>3.0 || DP<10" \
#    --filter-name "qc_filter" \
#    --missing-values-evaluate-as-failing \
#    2>${out_all}'/s21_all_2_VFcomplexShortDP_miss.log'
#
#gatk SelectVariants -R ${ref} -V ${out_all}'/s21_all_2_VFcomplexShortDP_miss.vcf.gz' \
#    -O ${out_all}'/s21_all_2_VFcomplexShortDP_miss_SVexcludeBIAL.vcf.gz' \
#    --exclude-filtered --restrict-alleles-to BIALLELIC \
#    2>${out_all}'/s21_all_2_VFcomplexShortDP_miss_SVexcludeBIAL.log'
##################################
#
#gatk VariantFiltration -R ${ref} -V ${in_HC_all}'/s21_smallTest.vcf.gz'  \
#    -O ${out_all}'/s21_all_3_VFDP10_miss.vcf.gz' \
#    --filter-expression "DP<10" \
#    --filter-name "qc_filter" \
#    --missing-values-evaluate-as-failing \
#    2>${out_all}'/s21_all_3_VFDP10_miss.log'
#
#gatk SelectVariants -R ${ref} -V ${out_all}'/s21_all_3_VFDP10_miss.vcf.gz' \
#    -O ${out_all}'/s21_all_3_VFDP10_miss_SVexcludeBIAL.vcf.gz' \
#    --exclude-filtered --restrict-alleles-to BIALLELIC \
#    2>${out_all}'/s21_all_3_VFDP10_miss_SVexcludeBIAL.log'
####################################

#gatk SelectVariants -R ${ref} -V ${out_all}'/s21_all_2_VFcomplexShortDP_miss.vcf.gz' \
#    -O ${out_all}'/s21_all_4_VFcomplexShortDP_miss_SVexcludeBIAL_NOVAR_SNP.vcf.gz' \
#    --exclude-filtered --restrict-alleles-to BIALLELIC --select-type-to-include SNP --select-type-to-include NO_VARIATION \
#    2>${out_all}'/s21_all_4_VFcomplexShortDP_miss_SVexcludeBIAL_NOVAR_SNP.log'
################################
#
#gatk SelectVariants -R ${ref} -V ${out_all}'/s21_all_3_VFDP10_miss.vcf.gz' \
#    -O ${out_all}'/s21_all_4_VFDP10_miss_SVexcludeBIAL_NOVAR_SNP.vcf.gz' \
#    --exclude-filtered --restrict-alleles-to BIALLELIC --select-type-to-include SNP --select-type-to-include NO_VARIATION \
#    2>${out_all}'/s21_all_4_VFDP10_miss_SVexcludeBIAL_NOVAR_SNP.log'
#
###############################
gatk SelectVariants -R ${ref} -V ${out_all}'/s21_all_3_VFDP10_miss.vcf.gz' \
    -O ${out_all}'/s21_all_5_VFDP10_miss_SVexcludeBIAL_NOVAR.vcf.gz' \
    --exclude-filtered --restrict-alleles-to BIALLELIC --select-type-to-include NO_VARIATION \
    2>${out_all}'/s21_all_5_VFDP10_miss_SVexcludeBIAL_NOVAR.log'


gatk SelectVariants -R ${ref} -V ${out_all}'/s21_smallTest.vcf.gz' \
    -O ${out_all}'/s21_all_5_SV_BIAL_NOVAR_SNP.vcf.gz' \
    --restrict-alleles-to BIALLELIC --select-type-to-include SNP --select-type-to-include NO_VARIATION \
    2>${out_all}'/s21_all_5_SV_BIAL_NOVAR_SNP.log'

gatk SelectVariants -R ${ref} -V ${out_all}'/s21_smallTest.vcf.gz' \
    -O ${out_all}'/s21_all_5_SV_DP10_BIAL_NOVAR_SNP.vcf.gz' \
    --restrict-alleles-to BIALLELIC --select-type-to-include NO_VARIATION \
    -select "DP<10" \
    2>${out_all}'/s21_all_5_SV_DP10_BIAL_NOVAR_SNP.log'




echo -e "\nA. File checks" | tee -a ${comp_all}
#
##set -x
file_filt='*all*.vcf.gz'
#
echo -e "\n### 1. check row number ###" | tee -a ${comp_all}
find ${out_all} -iname "*$file_filt" | sort -V | xargs -n1 -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | wc -l |  perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_all}; echo -e '\n'"

echo -e "\n### 2. check if QD<2 are eliminated ###" | tee -a ${comp_all}
#find ${out_all} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | grep -oP '(?<=QD=).*?(?=;)' | sort -n | uniq -c | (head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g'; echo -e '#######'; tail |  perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g') | tee -a ${comp_all}"
find ${out_all} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | grep -oP '(?<=QD=).*?(?=;)' | sort -n | uniq -c | head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_all}"

echo -e "\n### 3. check if FS>60 are eliminated ###" | tee -a ${comp_all}
find ${out_all} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | grep -oP '(?<=FS=).*?(?=;)' | sort -n | uniq -c | tail | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_all}"

echo -e "\n### 4. check if MQ<40 are eliminated ###" | tee -a ${comp_all}
find ${out_all} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | grep -oP '(?<=MQ=).*?(?=;)' | sort -n | uniq -c | head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_all}"

echo -e "\n### 5. check if SOR>3 are eliminated ###" | tee -a ${comp_all}
find ${out_all} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | cut -f 8 | awk -F 'SOR=' '{print \$2}' | sort -n | uniq -c | tail |  perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_all}"

echo -e "\n### 6. check if DP<10 are eliminated ###" | tee -a ${comp_all}
find ${out_all} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | grep -oP '(?<=DP=).*?(?=;)' | sort -n | uniq -c | head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_all}"
#################################

#find ${out_all} -iname "*$file_filt" | sort -V | xargs -n1 -I in_file sh -c "basename in_file | tee -a ${comp_all}; zcat in_file | grep -v '^#' | tee >(wc -l | sed 's/^/row_number: /') >(grep -oP '(?<=QD=).*?(?=;)' | sort -n | uniq -c | head | sed 's/^/QD<2 are eliminated? /') |  perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_all}; echo -e '\n'"




#wget -O - http://example.com/dvd.iso \
#  | tee >(sha1sum > dvd.sha1) \
#        >(md5sum > dvd.md5) \
#  > dvd.iso
#
#zcat s27_snp_5_VFcomplexShortDP_miss_SVexclude_SNP_ext.vcf.gz | grep -v '^#' | grep -oP "(?<=QD=).*?(?=;)" | sort -n | uniq -c > comp_QDs.txt 
#zcat s27_snp_5_VFcomplexShortDP_miss_SVexclude_SNP_BIAL.vcf.gz | grep -v '^#' | grep -oP "(?<=QD=).*?(?=;)" | sort -n | uniq -c | paste comp_QDs.txt - > tmp4.txt && mv -f tmp4.txt comp_QDs.txt 
#sed '1s/^/EXT_QD\tBIAL_QD\n/' comp_QDs.txt > tmp4.txt && mv -f tmp4.txt comp_QDs.txt 

#########################################
#########################################
#########################################
##########################################
##########################################


echo 'Done'
echo "Process done" | mail -s "Process done" balan@ie-freiburg.mpg.de
t30=$(date +%s)


