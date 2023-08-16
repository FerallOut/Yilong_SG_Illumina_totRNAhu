#!/bin/bash -l

# directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

{ read -r bam_SplitNCigar; } < <(yq -y '.paths."5_SplitNCigar"' sources.yaml)
bamSplitNCigar=${main_dir}${bam_SplitNCigar}

{ read -r HC_ERC; } < <(yq -y '.paths."5_HC_ERC"' sources.yaml)
HC_ERCvcfs=${main_dir}${HC_ERC}

{ read -r HC_ERCbams; } < <(yq -y '.paths."5_HC_ERC_bamOut"' sources.yaml)
HC_ERCbams=${main_dir}${HC_ERCbams}

{ read -r HC_ERClog; } < <(yq -y '.paths."5_HC_ERC_logs"' sources.yaml)
HC_ERClog=${main_dir}${HC_ERClog}

# files, references
{ read -r ref_genome; } < <(yq -y '.paths."genome_GRCh38"' sources.yaml)
genomeGRCh38=${main_dir}${ref_genome}

{ read -r bed_genomeSlop; } < <(yq -y '.paths."slop_p10_GRCh38"' sources.yaml)
bed_slop_genesGRCh38=${main_dir}${bed_genomeSlop}
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

# the script calls indels and SNPs on the prepared bam files
# and outputs vcf.gz files, re-arranged bam files and a log file

# the call is done only on genes that are on the main chromosomes [1-23XY]
# see the jupyter notebook for information about how the bed file was obtained

# this command runs in parallel for a maximum of 8 input files  
export bamSplitNCigar
export HC_ERCvcfs
export HC_ERCbams
export HC_ERClog
export genomeGRCh38
export bed_slop_genesGRCh38

find ${bamSplitNCigar} -iname "*_SplitCorr.bam" | sort -V | \
    xargs -n 1 -P 8 -I X sh -c 'file=$(basename X | cut -d '_' -f 1); t1=$(date +%s); gatk --java-options "-Xms20G -Xmx20G -XX:ParallelGCThreads=2" HaplotypeCaller -R ${genomeGRCh38} -L ${bed_slop_genesGRCh38} -I X --bam-output ${HC_ERCbams}/${file}"_HC_ERC.bam" -ERC BP_RESOLUTION -O ${HC_ERCvcfs}/$file"_HC_ERC.vcf.gz"  2>${HC_ERClog}/${file}"_HC_ERC.log"; t2=$(date +%s);  echo "** HaplotypeCaller in ERC mode for $(basename X) took $(date -ud "@$(( $t2 - $t1 ))" +"%H:%M:%S") (HH:MM:SS)"  ' 

t30=$(date +%s)   
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)" 
