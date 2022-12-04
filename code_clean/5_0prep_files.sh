#!/bin/sh

# directories
{ read -r main_dir; } < <(yq -y '.paths."main_dir"' sources.yaml)

{ read -r bams; } < <(yq -y '.paths."bam_files"' sources.yaml)
in_bam=${main_dir}${bams}

{ read -r bamSplit; } < <(yq -y '.paths."5_bamSplit"' sources.yaml)
bam_split=${main_dir}${bamSplit}

{ read -r bamSplit_RG; } < <(yq -y '.paths."5_bamSplit_RG"' sources.yaml)
bam_splitRG=${main_dir}${bamSplit_RG}

{ read -r bam_merged; } < <(yq -y '.paths."5_merged"' sources.yaml)
bam_mergedRG=${main_dir}${bam_merged}

{ read -r bam_SplitNCigar; } < <(yq -y '.paths."5_SplitNCigar"' sources.yaml)
bamSplitNCigar=${main_dir}${bam_SplitNCigar}

{ read -r SplitNCigar_logs; } < <(yq -y '.paths."5_SplitNCigar_logs"' sources.yaml)
logsSplitNCigar=${main_dir}${SplitNCigar_logs}

# files, references
{ read -r ref_genome; } < <(yq -y '.paths."genome_GRCh38"' sources.yaml)
genomeGRCh38=${main_dir}${ref_genome}
##################################################################

t0=$(date +%s)

printf "Script start: $(date +"%x %r %Z")\n***********************************\n"

# bam files are made of reads from 2 separate lanes so I can't add the correct RG tag to each of them
# the reads name between the 2 lanes only differ at one position
# make an array out of the names to use them for splitting the mixed bam files into 2 separate bam files 

IFS=', ' read -a array <<< "A00931:420:H7M2JDMXY:1, A00931:420:H7M2JDMXY:2" 

for k in $(find ${in_bam} -iname 's*.bam' -printf '%P\n' | sort -V)
do
    echo $k
    t1=$(date +%s)

    echo "*Splitting the file " $(basename ${k})

####### <--- Section 1: split bam files by lane to add RG tag late ---> #######

    for element in "${array[@]}"
    do
        echo "$element"
        flowcell=$(echo $element|cut -d ":" -f 3)

        (samtools view -H ${in_bam}'/'$k; samtools view -@ 10 ${in_bam}'/'$k | grep "$element") | \
            samtools view -@ 10 -bS - > ${bam_split}'/'$(basename ${k%%.bam*})_$(basename ${element##*:})'.bam'
        
        samtools view -c ${bam_split}'/'$(basename ${k%%.bam*})_$(basename ${element##*:})'.bam' | \
            tr '\n' ' ' | sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1.\2/;ta'; echo 'reads' 

######## <--- Section2: add RG groups with samtools addreplacerg ---> #######     

        echo "*Adding RG tags for " $(basename ${k%%.bam*})'_'$(basename ${element##*:})'.bam' 
        samtools addreplacerg -@ 10 \
            -r "@RG\tID:$(basename ${k%%.bam*}).$(echo $element|cut -d ":" -f 3 ).$(basename ${element##*:})\tSM:$(basename ${k%%.bam*})\tLB:lib1\tPL:illumina" \
            -o ${bam_splitRG}'/'$(basename ${k%%.bam*})'_'$(basename ${element##*:})'_RG.bam' \
            ${bam_split}'/'$(basename ${k%%.bam*})'_'$(basename ${element##*:})'.bam'  
    done

######## <--- Section 3: merge the 2 lanes for each bam sample file ---> #######

    samtools merge -@ 10 \
        ${bam_mergedRG}'/'$(basename ${k%%.bam*})'_RG.bam' \
        ${bam_splitRG}'/'$(basename ${k%%.bam*})'_1_RG.bam' \
        ${bam_splitRG}'/'$(basename ${k%%.bam*})'_2_RG.bam' 

    t2=$(date +%s)
    echo "** Splitting, adding RG tag and merging for file $k took $(date -ud "@$(($t2 - $t1))" +%T) (HH:MM:SS)"
done

######## <--- Section 4: reformat alignments and correct STAR mapping quality from 255 to 60 ---> #######

# this command runs in parallel for a maximum of 8 input files  
export genomeGRCh38 
export bamSplitNCigar
export logsSplitNCigar

find ${bam_mergedRG} -iname "*_RG.bam" | sort -V | \
     xargs -n 1 -P 8 -I X sh -c 'file=$(basename X | cut -d '_' -f 1); t3=$(date +%s); gatk SplitNCigarReads -R ${genomeGRCh38} -I X -O ${bamSplitNCigar}/$file"_SplitCorr.bam" 2>${logsSplitNCigar}/${file}"_SplitCorr.log"; t4=$(date +%s);  echo "** GATK correction for $(basename X) took $(date -ud "@$(( $t4 - $t3 ))" +%T) (HH:MM:SS)"  '

t30=$(date +%s)   
echo "Script ran for $(date -ud "@$(($t30 - $t0))" +%T) (HH:MM:SS)" 
