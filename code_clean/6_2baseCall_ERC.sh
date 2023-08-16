#!/bin/bash -l

# directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

{ read -r HC_ERC; } < <(yq -y '.paths."5_HC_ERC"' sources.yaml)
HC_ERCvcfs=${main_dir}${HC_ERC}
###################################

{ read -r HC_SNP; } < <(yq -y '.paths."5_HC_SNP"' sources.yaml)
HC_SNP=${main_dir}${HC_SNP}

{ read -r HC_SNPlog; } < <(yq -y '.paths."5_HC_SNP_log"' sources.yaml)
HC_SNPlog=${main_dir}${HC_SNPlog}

{ read -r HC_SNPfilt; } < <(yq -y '.paths."5_HC_SNP_filt"' sources.yaml)
HC_SNPfilt=${main_dir}${HC_SNPfilt}

{ read -r HC_SNPfiltLog; } < <(yq -y '.paths."5_HC_SNP_filtLog"' sources.yaml)
HC_SNPfiltLog=${main_dir}${HC_SNPfiltLog}
################################

{ read -r HC_all; } < <(yq -y '.paths."5_HC_all"' sources.yaml)
HC_all=${main_dir}${HC_all}

{ read -r HC_all_log; } < <(yq -y '.paths."5_HC_all_log"' sources.yaml)
HC_all_log=${main_dir}${HC_all_log}

{ read -r HC_allfilt; } < <(yq -y '.paths."5_HC_all_filt"' sources.yaml)
HC_all_filt=${main_dir}${HC_allfilt}

{ read -r HC_allfiltLog; } < <(yq -y '.paths."5_HC_all_filtLog"' sources.yaml)
HC_all_filtLog=${main_dir}${HC_allfiltLog}
##################################

# files, references
{ read -r bed_genomeSlop; } < <(yq -y '.paths."slop_p10_GRCh38"' sources.yaml)
bed_slop_genesGRCh38=${main_dir}${bed_genomeSlop}

{ read -r ref_genome; } < <(yq -y '.paths."genome_GRCh38"' sources.yaml)
genomeGRCh38=${main_dir}${ref_genome}
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

# the script outputs log files and 2 types of vcf files:
# one with only the SNPs
# the other with all the positions in the genome

# the call is done only on genes that are on the main chromosomes [1-23XY]
# see the jupyter notebook for information about how the bed file was obtained

# this command runs in parallel for a maximum of 8 input files  
export HC_ERCvcfs
export HC_SNP
export HC_SNPlog
export HC_SNPfilt
export HC_SNPfiltLog

export HC_all
export HC_all_log
export HC_all_filt
export HC_all_filtLog

export bed_slop_genesGRCh38
export genomeGRCh38

t0=$(date +%s)   

###For SNP genotyping and filtering:
find ${HC_ERCvcfs} -iname "*_HC_ERC.vcf.gz" | sort -rV | \
    xargs -n 1 -P 8 -I in_file sh -c 'file=$(basename in_file | cut -d '_' -f 1); \
        gatk --java-options "-Xms2G -Xmx2G -XX:ParallelGCThreads=2" GenotypeGVCFs -R ${genomeGRCh38} \
        -V in_file -O ${HC_SNP}/$file"_HC_SNP.vcf.gz" --tmp-dir /data/extended/ \
        --include-non-variant-sites false -L ${bed_slop_genesGRCh38} \
        --add-output-vcf-command-line  2>${HC_SNPlog}/${file}"_HC_SNP.log" ; \
        echo "** GenotypeGVCF SNP for $(basename in_file) done" ' 

## filter out each location (not SNPs):
find ${HC_SNP} -iname "*_HC_SNP.vcf.gz" | sort -rV | \
    xargs -n 1 -P 8 -I in_file sh -c 'file=$(basename in_file | cut -d '_' -f 1); gatk VariantFiltration -R ${genomeGRCh38} -V in_file \
         -O ${HC_SNPfilt}/$file"_SNPsoftFilt.vcf.gz" \
         --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || SOR>3.0 || DP < 10" \
         --filter-name "snp_filter" \
         --missing-values-evaluate-as-failing \
         2>${HC_SNPfiltLog}/${file}"_SNPsoftFilt.log"; 
         echo "** Soft filtering for $(basename in_file) done" ' 

find ${HC_SNPfilt} -iname "*_SNPsoftFilt.vcf.gz" | sort -rV | \
    xargs -n 1 -P 8 -I in_file sh -c 'file=$(basename in_file | cut -d '_' -f 1); gatk SelectVariants -R ${genomeGRCh38} -V in_file \
         -O ${HC_SNPfilt}/$file"_SNPFilt.vcf.gz" \
         --exclude-filtered --select-type-to-include SNP \
         --restrict-alleles-to BIALLELIC \
         2>${HC_SNPfiltLog}/${file}"_SNPFilt.log"; 
         echo "** Hard filtering for $(basename in_file) done" ' 
########################################

### For all the positions in the genome:
find ${HC_ERCvcfs} -iname "*_HC_ERC.vcf.gz" | sort -rV | \
    xargs -n 1 -P 8 -I in_file sh -c 'file=$(basename in_file | cut -d '_' -f 1); \
        gatk --java-options "-Xms2G -Xmx2G -XX:ParallelGCThreads=2" GenotypeGVCFs -R ${genomeGRCh38} \
        -V in_file -O ${HC_all}/$file"_HC_all.vcf.gz" --tmp-dir /data/extended/ \
        --include-non-variant-sites true -L ${bed_slop_genesGRCh38} \
        --add-output-vcf-command-line  2>${HC_all_log}/${file}"_HC_all.log"; \
        echo "** GenotypeGVCF for all positions for $(basename in_file) done." ' 

## filter out each location (not SNPs):
find ${HC_all} -iname "*_HC_all.vcf.gz" | sort -rV | \
    xargs -n 1 -P 8 -I in_file sh -c 'file=$(basename in_file | cut -d '_' -f 1); gatk SelectVariants -R ${genomeGRCh38} -V in_file \
         -O ${HC_all_filt}/$file"_allfiltDPgteq10.vcf.gz" \
         --selectExpressions "DP>=10"  \
         2>${HC_all_filtLog}/${file}"_allfiltDPgteq10.log"; echo "** Filtering for $(basename in_file)_all done"   '
##############################

t1=$(date +%s)   
