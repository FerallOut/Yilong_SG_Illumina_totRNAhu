output=$1  ##Projects/Drosophila/BamFiles/{sample}.bam
genomeindex=$2 ##/data/processing3/akhtargroup/sunyd/Projects/Drosophila/RawData/DrosophilaReferenceGenomeFlybase/star
read1=$3
read2=$4
threads=$5
directory=$6

runfolderpart=`echo $output |sed 's/.bam//g'`
runfolder=$directory/$runfolderpart
mkdir -p $runfolder

bam=`echo $runfolder |rev |cut -d "/" -f1 |rev`
bamfilefolder=`echo $runfolder |rev |cut -d "/" -f2-100 |rev`
mkdir -p $bamfilefolder
mkdir -p ${bamfilefolder}Duplicates

fastq=`echo $read1 |rev |cut -d "/" -f2-100 |rev`
cp -r $fastq $runfolder
cd $runfolder

STAR --genomeDir $genomeindex --readFilesCommand zcat --readFilesIn $read1 $read2 --runThreadN $threads --outFilterMismatchNmax 2 --outFilterMultimapScoreRange 0 --alignIntronMax 500000

samtools view -b -h -S -q 7 -@ $threads Aligned.out.sam > Aligned.out.bam

rm -f Aligned.out.sam

samtools view -b -h -f99 -@ $threads Aligned.out.bam > watson.first.bam
samtools view -b -h -f147 -@ $threads Aligned.out.bam > watson.second.bam
samtools view -b -h -f83 -@ $threads Aligned.out.bam > crick.first.bam
samtools view -b -h -f163 -@ $threads Aligned.out.bam > crick.second.bam

samtools merge -@ $threads - watson.first.bam watson.second.bam crick.first.bam crick.second.bam | samtools sort -@ $threads - ${bamfilefolder}Duplicates/$bam
samtools index ${bamfilefolder}Duplicates/${bam}.bam

rm -f *bam
rm -rf $runfolder/$fastq

cd $bamfilefolder
samtools rmdup ${bamfilefolder}Duplicates/${bam}.bam $bamfilefolder/${bam}.bam
samtools index ${bam}.bam

bamupperfolder=`echo $runfolder |rev |cut -d "/" -f3-100 |rev`
project=`echo $output |cut -d "/" -f1`

samfilesfolder=$bamupperfolder/NameSortedSamFiles/
samfilesfolderduplicates=$bamupperfolder/NameSortedSamFilesDuplicates/
mkdir -p $samfilesfolder
mkdir -p $samfilesfolderduplicates

samtools sort -n -o -@ $threads ${bam}.bam ${bam}.namesorted | samtools view -h - | gzip > ${samfilesfolder}/${bam}.namesorted.sam.gz

cd ${bamfilefolder}Duplicates
samtools sort -n -o -@ $threads ${bam}.bam ${bam}.namesorted | samtools view -h - | gzip > $samfilesfolderduplicates/${bam}.namesorted.sam.gz

cd $bamfilefolder
bamfileschr=$bamupperfolder/BamFilesChr
mkdir -p $bamfileschr

samtools view -H ${bam}.bam |sed 's/SN:/SN:chr/g' > header.sam
samtools reheader header.sam ${bam}.bam > $bamfileschr/${bam}.bam
cd $bamfileschr
samtools index ${bam}.bam
module load deeptools/3.0.2
bamCoverage --normalizeUsing RPKM -p $threads -b ${bam}.bam -o ${bam}.bw


cd $samfilesfolder


###htseq-count

outfolder=$bamupperfolder/CountFiles/
mkdir -p $outfolder

anno=$directory/$project/ProcessedData/AnnotationObjects/spikeins.gtf
outfolder=$bamupperfolder/CountFiles/SpikeIns/
mkdir $outfolder

#htseq-count -m intersection-strict -t transcript -i gene_id --stranded=yes ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.gtf
outfolder=$bamupperfolder/CountFiles/GeneMerge/
mkdir $outfolder

htseq-count -m intersection-strict -t transcribed_region -i id --stranded=yes ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/species.database.constitutive.exons.gtf
outfolder=$bamupperfolder/CountFiles/ConstitutiveExons/
mkdir $outfolder

htseq-count -m intersection-strict -t constitutive_exons -i CE_id --stranded=yes ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/species.database.constitutive.introns.gtf
outfolder=$bamupperfolder/CountFiles/ConstitutiveIntrons/
mkdir $outfolder

htseq-count -m intersection-strict -t constitutive_introns -i CI_id --stranded=yes ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/spikeins.gtf
outfolder=$bamupperfolder/CountFiles/SpikeInsAntisense/
mkdir $outfolder

#htseq-count -m intersection-strict -t transcript -i gene_id --stranded=reverse ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.gtf
outfolder=$bamupperfolder/CountFiles/GeneMergeAntisense/
mkdir $outfolder

htseq-count -m intersection-strict -t transcribed_region -i id --stranded=reverse ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/species.database.constitutive.exons.gtf
outfolder=$bamupperfolder/CountFiles/ConstitutiveExonsAntisense/
mkdir $outfolder

htseq-count -m intersection-strict -t constitutive_exons -i CE_id --stranded=reverse ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/species.database.constitutive.introns.gtf
outfolder=$bamupperfolder/CountFiles/ConstitutiveIntronsAntisense/
mkdir $outfolder

htseq-count -m intersection-strict -t constitutive_introns -i CI_id --stranded=reverse ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

#rm -f ${samfilesfolder}/${bam}.namesorted.sam.gz


###without removing duplicates
cd  $samfilesfolderduplicates
###htseq-count
anno=$directory/$project/ProcessedData/AnnotationObjects/spikeins.gtf
outfolder=$bamupperfolder/CountFiles/SpikeIns/
mkdir $outfolder

htseq-count -m intersection-strict -t transcript -i gene_id --stranded=yes ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

anno=$directory/$project/ProcessedData/AnnotationObjects/spikeins.gtf
outfolder=$bamupperfolder/CountFiles/SpikeInsAntisense/
mkdir $outfolder

htseq-count -m intersection-strict -t transcript -i gene_id --stranded=reverse ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

