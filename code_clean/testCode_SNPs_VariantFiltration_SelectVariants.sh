#!/bin/bash -l

# load modules
module load samtools picard-tools gatk4

# directories
main_dir='/data/manke/group/balan/projects/Yilong_SG_Illumina_totRNAhu'

#in_HC_SNP=${main_dir}'/output/5_SNP_TtoCmut/6_SNP/1_SNP_Genotype_vcfs'
#out_SNP=${main_dir}'/output/5_SNP_TtoCmut/6_SNP/testSNP_VF_SV'
out_SNP=${main_dir}'/output/5_SNP_TtoCmut/6_SNP/2_SNP_filter'

# files, references
ref=${main_dir}'/data_int/references/GRCh38_genome.fa'
#########################################################################

#comp_SNP=${out_SNP}'/comp_SNP.txt'
comp_SNP=${main_dir}'/output/5_SNP_TtoCmut/6_SNP/test_SNP.txt'
##################################################################

rm ${comp_SNP}

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

t19=$(date +%s)

echo "A. Soft SNPs extraction - create files"

echo "### A.1) with exclude_without SNP"
echo "### ** VF_complexShort_DP10, SV_exclude, expand"

#gatk VariantFiltration -R ${ref} -V ${in_HC_SNP}'/s27_HC_SNP.vcf.gz'  \
#    -O ${out_SNP}'/s27_snp_1_VFcomplexShortDP.vcf.gz' \
#    --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || SOR>3.0 || DP < 10" \
#    --filter-name "snp_filter" \
#    2>${out_SNP}'/s27_snp_1_VFcomplexShortDP.log' 

#gatk SelectVariants -R ${ref} -V ${out_SNP}'/s27_snp_1_VFcomplexShortDP.vcf.gz' \
#    -O ${out_SNP}'/s27_snp_1_VFcomplexShortDP_SVexclude.vcf.gz'  --exclude-filtered \
#    2>${out_SNP}'/s27_snp_1_VFcomplexShortDP_SVexclude.log'
#
#bcftools view --max-alleles 2 --threads 8 --min-alleles 2 \
#    ${out_SNP}'/s27_snp_1_VFcomplexShortDP_SVexclude.vcf.gz' \
#    -o ${out_SNP}'/s27_snp_1_VFcomplexShortDP_SVexclude_ext.vcf.gz' \
#    2>${out_SNP}'/s27_snp_1_VFcomplexShortDP_SVexclude_ext.log'; \
#    tabix -p vcf ${out_SNP}'/s27_snp_1_VFcomplexShortDP_SVexclude_ext.vcf.gz'
##############################
#
echo "### A.2) without exclude_without SNP"
echo "### ** VF_complexShort_DP10, SV, expand"

#gatk SelectVariants -R ${ref} -V ${out_SNP}'/s27_snp_1_VFcomplexShortDP.vcf.gz' \
#    -O ${out_SNP}'/s27_snp_2_VFcomplexShortDP_SV.vcf.gz' \
#    2>${out_SNP}'/s27_snp_2_VFcomplexShortDP_SV.log' 
#
#bcftools view --max-alleles 2 --threads 8 --min-alleles 2 \
#    ${out_SNP}'/s27_snp_2_VFcomplexShortDP_SV.vcf.gz' \
#    -o ${out_SNP}'/s27_snp_2_VFcomplexShortDP_SV_ext.vcf.gz' \
#    2>${out_SNP}'/s27_snp_2_VFcomplexShortDP_SV_ext.log'; \
#    tabix -p vcf ${out_SNP}'/s27_snp_2_VFcomplexShortDP_SV_ext.vcf.gz'
################################

### conclusion: with exclude

###############################

echo "### A.3) with exclude_with SNP"
echo "### ** VF_complexShort_DP10, SV_exclude_SNP, expand"

#gatk SelectVariants -R ${ref} -V ${out_SNP}'/s27_snp_1_VFcomplexShortDP.vcf.gz' \
#    -O ${out_SNP}'/s27_snp_3_VFcomplexShortDP_SVexclude_SNP.vcf.gz' --exclude-filtered --select-type-to-include SNP \
#    2>${out_SNP}'/s27_snp_3_VFcomplexShortDP_SVexclude_SNP.log'

#bcftools view --max-alleles 2 --threads 8 --min-alleles 2 \
#    ${out_SNP}'/s27_snp_3_VFcomplexShortDP_SVexclude_SNP.vcf.gz' \
#    -o ${out_SNP}'/s27_snp_3_VFcomplexShortDP_SVexclude_SNP_ext.vcf.gz' \
#    2>${out_SNP}'/s27_snp_3_VFcomplexShortDP_SVexclude_SNP_ext.log'; \
#    tabix -p vcf ${out_SNP}'/s27_snp_3_VFcomplexShortDP_SVexclude_SNP_ext.vcf.gz'
###############################

### conclusion: with exclusion and with SNP

###############################

echo "### A.4) without exclude_with SNP"
echo "### ** VF_complexShort_DP10, SV_SNP, expand"
#
#gatk SelectVariants -R ${ref} -V ${out_SNP}'/s27_snp_1_VFcomplexShortDP.vcf.gz' \
#    -O ${out_SNP}'/s27_snp_4_VFcomplexShortDP_SV_SNP.vcf.gz' --select-type-to-include SNP \
#    2>${out_SNP}'/s27_snp_4_VFcomplexShortDP_SV_SNP.log'
#
#bcftools view --max-alleles 2 --threads 8 --min-alleles 2 \
#    ${out_SNP}'/s27_snp_4_VFcomplexShortDP_SV_SNP.vcf.gz' \
#    -o ${out_SNP}'/s27_snp_3_VFcomplexShortDP_SV_SNP_ext.vcf.gz' \
#    2>${out_SNP}'/s27_snp_3_VFcomplexShortDP_SV_SNP_ext.log'; \
#    tabix -p vcf ${out_SNP}'/s27_snp_3_VFcomplexShortDP_SV_SNP_ext.vcf.gz'
###############################

### conclusion: with exclusion and with SNP

###############################

echo "### A.5) with exclude_with SNP_with ewith missing-valuesSNP"
echo "### ** VF_complexShort_DP10_miss, SV_exclude, expand"

#gatk VariantFiltration -R ${ref} -V ${in_HC_SNP}'/s27_HC_SNP.vcf.gz'  \
#    -O ${out_SNP}'/s27_snp_5_VFcomplexShortDP_miss.vcf.gz' \
#    --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || SOR>3.0 || DP < 10" \
#    --filter-name "snp_filter" \
#    --missing-values-evaluate-as-failing \
#    2>${out_SNP}'/s27_snp_5_VFcomplexShortDP_miss.log' 
#
#gatk SelectVariants -R ${ref} -V ${out_SNP}'/s27_snp_5_VFcomplexShortDP_miss.vcf.gz' \
#    -O ${out_SNP}'/s27_snp_5_VFcomplexShortDP_miss_SVexclude_SNP_BIAL.vcf.gz'  --exclude-filtered --select-type-to-include SNP \
#    --restrict-alleles-to BIALLELIC \
#    2>${out_SNP}'/s27_snp_5_VFcomplexShortDP_miss_SVexclude_SNP_BIAL.log' 
##########################################

### conclusion: with exclusion and with SNP ????

###############################

echo -e "\nA. File checks" | tee -a ${comp_SNP}

#set -x
file_filt='SNPFilt.vcf.gz'

echo -e "\n### 1. check row number ###" | tee -a ${comp_SNP}
find ${out_SNP} -iname "*$file_filt" | sort -V | xargs -n1 -I in_file sh -c "basename in_file | tee -a ${comp_SNP}; zcat in_file | grep -v '^#' | wc -l |  perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_SNP}; echo -e '\n'"

echo -e "\n### 2. check if QD<2 are eliminated ###" | tee -a ${comp_SNP}
#find ${out_SNP} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_SNP}; zcat in_file | grep -v '^#' | grep -oP '(?<=QD=).*?(?=;)' | sort -n | uniq -c | (head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g'; echo -e '#######'; tail |  perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g') | tee -a ${comp_SNP}"
find ${out_SNP} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_SNP}; zcat in_file | grep -v '^#' | grep -oP '(?<=QD=).*?(?=;)' | sort -n | uniq -c | head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_SNP}"

echo -e "\n### 3. check if FS>60 are eliminated ###" | tee -a ${comp_SNP}
find ${out_SNP} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_SNP}; zcat in_file | grep -v '^#' | grep -oP '(?<=FS=).*?(?=;)' | sort -n | uniq -c | tail | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_SNP}"

echo -e "\n### 4. check if MQ<40 are eliminated ###" | tee -a ${comp_SNP}
find ${out_SNP} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_SNP}; zcat in_file | grep -v '^#' | grep -oP '(?<=MQ=).*?(?=;)' | sort -n | uniq -c | head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_SNP}"

echo -e "\n### 5. check if SOR>3 are eliminated ###" | tee -a ${comp_SNP}
find ${out_SNP} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_SNP}; zcat in_file | grep -v '^#' | cut -f 8 | awk -F 'SOR=' '{print \$2}' | sort -n | uniq -c | tail |  perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_SNP}"

echo -e "\n### 6. check if DP<10 are eliminated ###" | tee -a ${comp_SNP}
find ${out_SNP} -iname "*$file_filt" | sort -V | xargs -I in_file sh -c "basename in_file | tee -a ${comp_SNP}; zcat in_file | grep -v '^#' | grep -oP '(?<=DP=).*?(?=;)' | sort -n | uniq -c | head | perl -pe 's/(\d{1,3})(?=(?:\d{3}){1,5}\b)/\1,/g' | tee -a ${comp_SNP}"
################################

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


