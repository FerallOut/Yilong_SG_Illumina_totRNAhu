#!/bin/bash -l

# directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

{ read -r bam_SplitNCigar; } < <(yq -y '.paths."5_SplitNCigar"' sources.yaml)
bamSplitNCigar=${main_dir}${bam_SplitNCigar}

{ read -r HC_norm; } < <(yq -y '.paths."5_HC_norm"' sources.yaml)
HCnorm_vcfs=${main_dir}${HC_norm}

{ read -r HC_normBams; } < <(yq -y '.paths."5_HC_norm_bamOut"' sources.yaml)
HCnorm_bams=${main_dir}${HC_normBams}

{ read -r HC_normLog; } < <(yq -y '.paths."5_HC_norm_logs"' sources.yaml)
HCnorm_log=${main_dir}${HC_normLog}

# files, references
{ read -r ref_genome; } < <(yq -y '.paths."genome_GRCh38"' sources.yaml)
genomeGRCh38=${main_dir}${ref_genome}

{ read -r bed_genomeSlop; } < <(yq -y '.paths."slop_p10_GRCh38"' sources.yaml)
bed_slop_genesGRCh38=${main_dir}${bed_genomeSlop}
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

# the script calls SNPs on the prepared bam files
# and outputs vcf.gz files, re-arranged bam files and a log file

# the call is done only on genes that are on the main chromosomes [1-23XY]
# see the jupyter notebook for information about how the bed file was obtained

# this command runs in parallel for a maximum of 8 input files  
export bamSplitNCigar
export HCnorm_vcfs
export HCnorm_bams
export HCnorm_log
export genomeGRCh38
export bed_slop_genesGRCh38

find ${bamSplitNCigar} -iname "*_SplitCorr.bam" | sort -V | \
    xargs -n 1 -P 8 -I X sh -c 'file=$(basename X | cut -d '_' -f 1); t1=$(date +%s); gatk HaplotypeCaller -R ${genomeGRCh38} -L ${bed_slop_genesGRCh38} -I X --bam-output ${HCnorm_bams}/${file}"_HCnorm.bam" -O ${HCnorm_vcfs}/$file"_HCnorm.vcf.gz"  2>${HCnorm_log}/${file}"_HCnorm.log"; t2=$(date +%s);  echo "** HaplotypeCaller in normal mode for $(basename X) took $(date -ud "@$(( $t2 - $t1 ))" +%T) (HH:MM:SS)"  ' 

t30=$(date +%s)   
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)" 
