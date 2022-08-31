output=$1
directory=$2
selected_erna=$3

if [ $selected_erna == "new" ]; then
countfilefolder=`echo $output |rev |cut -d / -f3-100 |rev`
countupperfolder=`echo $output |rev |cut -d / -f4-100 |rev`
project=`echo $output |cut -d "/" -f1`
bam=`echo $output |rev |cut -d "/" -f1 |rev |cut -d "." -f1`
cellline=`echo $bam |cut -d "_" -f6,7 |sed 's/_//g'`

samfilesfolder=$directory/$countupperfolder/NameSortedSamFiles
cd $samfilesfolder


anno=$directory/$project/ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.eRNA.${cellline}.gtf

outfolder=$directory/$countfilefolder/GeneMergeAndeRNA/
mkdir -p $outfolder

htseq-count -m intersection-strict -t transcribed_region -i id --stranded=yes ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

outfolder=$directory/$countfilefolder/GeneMergeAndeRNAAntisense/
mkdir -p $outfolder

htseq-count -m intersection-strict -t transcribed_region -i id --stranded=reverse ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

else
countfilefolder=`echo $output |rev |cut -d / -f3-100 |rev`
countupperfolder=`echo $output |rev |cut -d / -f4-100 |rev`
project=`echo $output |cut -d "/" -f1`
project_selected=`echo $selected_erna |rev |cut -d "/" -f2 |rev`
bam=`echo $output |rev |cut -d "/" -f1 |rev |cut -d "." -f1`
cellline=`echo $bam |cut -d "_" -f6 |sed 's/_//g'`

samfilesfolder=$directory/$countupperfolder/NameSortedSamFiles
cd $samfilesfolder


anno=$directory/$project_selected/ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.eRNA.${cellline}wildtype.gtf

echo $anno
outfolder=$directory/$countfilefolder/GeneMergeAndeRNASelected/
mkdir -p $outfolder

htseq-count -m intersection-strict -t transcribed_region -i id --stranded=yes ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular

outfolder=$directory/$countfilefolder/GeneMergeAndeRNAAntisenseSelected/
mkdir -p $outfolder

htseq-count -m intersection-strict -t transcribed_region -i id --stranded=reverse ${bam}.namesorted.sam.gz $anno > ${outfolder}/${bam}.tabular


fi


