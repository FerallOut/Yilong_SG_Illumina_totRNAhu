#!/bin/bash -l

# add to the beginning of the script to then get all the echos and outputs into the 'log.out' file
#exec 3>&1 4>&2
#trap 'exec 2>&4 1>&3' 0 1 2 3              # ?succesfully run?, SIGUP, SIGINIT (ctrl-C) , SIGQUIT (quit)
#exec 1>output.log 2>output.err #&1

# load modules
module load samtools picard-tools gatk4

# directories
main_dir='/data/manke/processing/balan/Yilong_SG_data/run_2218/2022.03_DE_genes_transcript'
bam_split='5_SNP_TtoCmutation_analysis/1_bam_split'
bam_RG_dir='5_SNP_TtoCmutation_analysis/2a_bam_addRG_AddOr_Picard'
bam_RG_sam='5_SNP_TtoCmutation_analysis/2b_bam_addRG_sam'
merged_picard='5_SNP_TtoCmutation_analysis/bam_RG_picard_merged'  # deleted in the end because it was a test
merged_sam='5_SNP_TtoCmutation_analysis/3c_2b_bam_RG_merge'
corr_GATK='5_SNP_TtoCmutation_analysis/4b_bam_RG_merge_GATKcorr'
#NM_GATK='5_SNP_TtoCmutation_analysis/5b_bam_RG_merge_GATKcorr_NM'
#call_mutect2_GATKcorr='5_SNP_TtoCmutation_analysis/6b_bam_RG_merge_GATKcorr_NM_mutect2'
call_HC_GATKcorr='5_SNP_TtoCmutation_analysis/6b_bam_RG_merge_GATKcorr_HaplotypeCaller'
ins_HC_GATKcorrERC='5_SNP_TtoCmutation_analysis/7b_bam_RG_merge_GATKcorr_HC_ERCdb_GenoGVCFs'
out_HC_GATKcorrERC='5_SNP_TtoCmutation_analysis/8b_GATKcorr_ERCvcfs'

ins_HC_GATKcorr='5_SNP_TtoCmutation_analysis/7b_bam_RG_merge_GATKcorr_HC_vcfs'
ins_HC_GATKcorrFiltPASS='5_SNP_TtoCmutation_analysis/7b_bam_RG_merge_GATKcorr_HC_vcfs_QD2.0_FS60.0_MQ_40.0_HS_13.0_MQRS12.5'

# make needed directories
mkdir -p \
         ${main_dir}'/'${bam_split} ${main_dir}'/'${bam_RG_dir} ${main_dir}'/'${bam_RG_sam} \
         ${main_dir}'/'${merged_picard} ${main_dir}'/'${merged_sam} \
         ${main_dir}'/'${corr_man} ${main_dir}'/'${corr_GATK} \
         ${main_dir}'/'${call_HC_manCorr} ${main_dir}'/'${call_HC_GATKcorr}
	 ${main_dir}'/'${ins_HC_manCorr}'/log/' ${main_dir}'/'${ins_HC_GATKcorr}'/log/'

# files, references
ref='/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa'
gene_bed=${main_dir}'/5_SNP_TtoCmutation_analysis/bed/5_genes_bedops_chrBedextract_slop_p10.bed' 
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"
  #exec > split.log

# bam files are made of reads from 2 separate lanes so I can't add the correct RG tag to each of them
# the reads name between the 2 lanes only differ at one position
# make an array out of the names to use them for splitting the mixed bam files into 2 separate bam files 

#l.split_string=( "A00931:420:H7M2JDMXY:1" "A00931:420:H7M2JDMXY:2" )    # doesn't work on server

IFS=', ' read -a array <<< "A00931:420:H7M2JDMXY:1, A00931:420:H7M2JDMXY:2" # make an array 
  #echo "${array[@]}"


for k in $(find ${main_dir}'/bam' -iname 's*.bam' -printf '%P\n' | sort -V)
do
    echo $k
    #echo $(basename ${k%%.bam*})
    t1=$(date +%s)
#############################################



####### <--- Section 1: split bam files by lane to add RG tag late ---> #######

    #for index in ${!array[@]}
    for element in "${array[@]}"
    do
        
        #echo $index
        #echo ${array[index]}
        echo "$element"
        flowcell=$(echo $element|cut -d ":" -f 3)
        #echo $flowcell

        t2=$(date +%s)
        (samtools view -H ${main_dir}'/bam/'$k; samtools view -@ 10 ${main_dir}'/bam/'$k | grep "$element") | samtools view -@ 10 -bS - > ${main_dir}'/'${bam_split}'/'$(basename ${k%%.bam*})_$(basename ${element##*:})'.bam'
        samtools view -c ${main_dir}'/'${bam_split}'/'$(basename ${k%%.bam*})_$(basename ${element##*:})'.bam' | tr '\n' ' ' | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1.\2/;ta'; echo 'reads' 

        t3=$(date +%s)
        echo "Splitting for lane $(basename ${element##*:}) took $(date -ud "@$(($t3 - $t2))" +%T) (HH:MM:SS)"


     
####### <--- Section2 and 3: add RG groups and then merge the files ---> #######
  
        # A TRIAL - IN THE END I WENT WITH THE SAMTOOLS ADDREPLACERG because it was faster 
        #echo "Adding RG tags with AddOrReplaceReadGroups"
        #java -jar /package/picard-tools-2.26.11/picard.jar AddOrReplaceReadGroups \
        #    -I ${main_dir}'/'${bam_split}'/'$(basename ${k%%.bam*})_$(basename ${element##*:})'.bam' \
        #    -O ${main_dir}'/'${bam_RG_dir}'/'$(basename ${k%%.bam*})_'L'$(basename ${element##*:})'_RG_picard.bam' \
        #    -RGID $(basename ${k%%.bam*})'.'$(echo $element|cut -d ":" -f 3 )'.'$(basename ${element##*:}) \
        #    -RGLB lib1 -RGPL illumina \
        #    -RGPU $(echo $element|cut -d ":" -f 3 )'.'$(basename ${element##*:}) \
        #    -RGSM $(basename ${k%%.bam*})


        t4=$(date +%s)
        echo "Adding RG tags with samtools addreplacerg"
        samtools addreplacerg -@ 10 \
            -r "@RG\tID:$(basename ${k%%.bam*}).$(echo $element|cut -d ":" -f 3 ).$(basename ${element##*:})\tSM:$(basename ${k%%.bam*})\tLB:lib1\tPL:illumina" \
            -o ${main_dir}'/'${bam_RG_sam}'/'$(basename ${k%%.bam*})'_'$(basename ${element##*:})'_RGsam.bam' \
            ${main_dir}'/'${bam_split}'/'$(basename ${k%%.bam*})'_'$(basename ${element##*:})'.bam'  
        t5=$(date +%s)
        echo "Adding RG tags for lane $(basename ${element##*:}) took $(date -ud "@$(($t5 - $t4))" +%T) (HH:MM:SS)"
    done

    t6=$(date +%s)
    echo "** Splitting and adding RG tags for file $(basename ${k%%.bam*}) took $(date -ud "@$(($t6 - $t1))" +%T) (HH:MM:SS)"


    t7=$(date +%s)
    samtools merge -@ 10 ${main_dir}'/'${merged_sam}'/'$(basename ${k%%.bam*})'_RG_sam.bam'  \
        ${main_dir}'/'${bam_RG_sam}'/'$(basename ${k%%.bam*})'_'*'_RGsam.bam'

    t8=$(date +%s)
    echo "** Merging the 2 lanes of file $(basename ${k%%.bam*}) took $(date -ud "@$(( $t8 - $t7 ))" +%T) (HH:MM:SS)"






####### <--- Section 4: correct the STAR mapping quality from 255 to 60 ---> #######

    #correct with GATK: change 255 to 60 + trim
    t11=$(date +%s)
    gatk SplitNCigarReads -R ${ref} -I ${main_dir}'/'${merged_sam}'/'$(basename ${k%%.bam*})'_RG_sam.bam' -O ${main_dir}'/'${corr_GATK}'/'$(basename ${k%%.bam*})'_corrGATK.bam'

    # DOES IT NEED SORTING?
    samtools index -@ 20 ${main_dir}'/'${corr_GATK}'/'$(basename ${k%%.bam*})'_corrGATK.bam'

    t12=$(date +%s)
    echo "** 255-60 GATK correction for $(basename ${k%%.bam*}) took $(date -ud "@$(( $t12 - $t11 ))" +%T) (HH:MM:SS)"




	
####### <--- Section 6: call mutations with HaplotypeCaller ---> #######
# I have made the choice to call the mutations only on the genes that are on the main chromosomes
# so I have made a bed file containing only the gene level information
# from which I have removed the genes that mapped to scaffolds or MT
    t15=$(date +%s)

# Here I have used a separate script to run each file through slurm because it took a very long time, but this is the code that I have used in general: run_HaplotypeCaller_on_Slurm.sh
# The command with ERC is needed to extract all the bases that were covered by reads

    gatk HaplotypeCaller -R ${ref} -L ${gene_bed} \
        -I ${main_dir}'/'${corr_GATK}'/'$(basename ${k%%.bam*})'_corrGATK.bam' \
        --bam-output ${main_dir}'/'${call_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_RG_GATKcorr_ERC.bam' \
        -ERC BP_RESOLUTION \
        -O ${main_dir}'/'${call_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKcorrERC.vcf.gz'  2>${main_dir}'/'${call_HC_GATKcorr}'/log/'$(basename ${k%%.bam*})'_HaplotypeCallerERC.log' 
    t16=$(date +%s)
    echo "** Calling mutations with ERC BP_RESOLUTION mode in HaplotypeCaller for ${file} took $(date -ud "@$(( $t16 - $t15 ))" +%T) (HH:MM:SS)"


    t17=$(date +%s)

    gatk HaplotypeCaller -R ${ref} -L ${gene_bed} \
        -I ${main_dir}'/'${corr_GATK}'/'$(basename ${k%%.bam*})'_corrGATK.bam' \
        --bam-output ${main_dir}'/'${call_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_RG_GATKcorr.bam' \
        -O ${main_dir}'/'${call_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKCorr.vcf.gz'  2>${main_dir}'/'${call_HC_GATKcorr}'/log/'$(basename ${k%%.bam*})'_HaplotypeCaller.log' 

    t18=$(date +%s)
    echo "** Calling mutations with normal mode in HaplotypeCaller for ${file} took $(date -ud "@$(( $t18 - $t17 ))" +%T) (HH:MM:SS)"






####### <--- Section 7: extract SNPs and filter them out ---> #######

   t21=$(date +%s)
    echo "SNPs extraction with VariantFiltration for normal call"  

    gatk SelectVariants -R ${ref} -V ${main_dir}'/'${call_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKCorr.vcf.gz' \
        --select-type-to-include SNP \
        -O ${main_dir}'/'${ins_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs.vcf.gz' \
        2>${main_dir}'/'${ins_HC_GATKcorr}'/log/'$(basename ${k%%.bam*})'_SelVar.log'

    echo "Soft filtering of variants"
    gatk VariantFiltration -R ${ref} -V ${main_dir}'/'${ins_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs.vcf.gz'  \
        -O ${main_dir}'/'${ins_HC_GATKcorrFiltPASS}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_filt.vcf.gz' \
        --filter-expression "QUAL<30.0 || QD < 2.0 || FS > 60.0 || MQ < 40.0 || SOR>3.0 || DP < 10" \
	 --filter-name "snp_filter" \
        2>${main_dir}'/'${ins_HC_GATKcorrFiltPASS}'/log/'$(basename ${k%%.bam*})'_VarFilt.log'
 
    gatk SelectVariants -R ${ref} -V ${main_dir}'/'${ins_HC_GATKcorrFiltPASS}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_filt.vcf.gz' \
         -O ${main_dir}'/'${ins_HC_GATKcorrFiltPASS}'/'$(basename ${k%%.bam*})'_GATKCorr_SNPs_filtPASS.vcf.gz'  --exclude-filtered \
         2>${main_dir}'/'${ins_HC_GATKcorrFiltPASS}'/log/'$(basename ${k%%.bam*})'_PASSFilt.log'

    t22=$(date +%s)
    echo "** Filtering SNPs with manually correction for $(basename ${k%%.bam*}) took $(date -ud "@$(( $t22 - $t21 ))" +%T) (HH:MM:SS)"




    t19=$(date +%s)
    echo "SNPs extraction for ERC calling"
    echo "Create the DBs with GenomicDBImport"  
    gatk GenomicsDBImport -V ${main_dir}'/'${call_HC_GATKcorr}'/'$(basename ${k%%.bam*})'_GATKcorrERC.vcf.gz' \
        --genomicsdb-workspace-path ${main_dir}'/'${ins_HC_GATKcorrERC}'/'$(basename ${k%%.bam*})'_db' --tmp-dir /data/extended/ \
        -L ${gene_bed} --max-num-intervals-to-import-in-parallel 8 --reader-threads 8

    echo "Genotyping with GenotypeGVCFs"  
    gatk GenotypeGVCFs -R ${ref} -V gendb://${main_dir}'/'${ins_HC_GATKcorrERC}'/''${file}'_db  \
        -O ${main_dir}'/'${ins_HC_GATKcorrERC}'/''${file}'_ERC_genoGVCFs.vcf.gz --tmp-dir /data/extended/ \
        --include-non-variant-sites true -L ${gene_bed} --add-output-vcf-command-line
done
##########################################

t30=$(date +%s)


	echo "Processing complete at $(date +"%x %r %Z")"
	echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)"


