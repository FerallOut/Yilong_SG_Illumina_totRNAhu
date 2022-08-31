
suppressPackageStartupMessages(library(eisaR))
suppressPackageStartupMessages(library(GenomicFeatures))
suppressPackageStartupMessages(library(TxDb.Hsapiens.UCSC.hg38.knownGene))
suppressPackageStartupMessages(library(QuasR))
suppressPackageStartupMessages(library(Rhisat2))
suppressPackageStartupMessages(library(parallel))

# load the object:
txHu <- TxDb.Hsapiens.UCSC.hg38.knownGene

# extract filtered exonic and gene body regions
regS <- eisaR::getRegionsFromTxDb(txdb = txHu, strandedData = TRUE)
regU <- eisaR::getRegionsFromTxDb(txdb = txHu, strandedData = FALSE)

lengths(regS)
lengths(regU)

### 2. Quantify RNA-seq alignments into exons and introns

#### 2.1. Align reads

# create the sample sheet for paired-end sequencing:
path_inDir <- "/data/manke/processing/balan/Yilong_SG_data/2022.03_DE_genes_transcript"
orig_ss <- read.delim(paste0(path_inDir, "/", "sampleSheets/all_batch_corrected_sampleSheet.tsv"), header = TRUE, sep='\t', na.strings="NA")
  
fastq_location <- paste0(path_inDir, "/", "fastq")

FileName1 <- list.files(path = fastq_location, pattern = '_R1.fastq.gz', all.files = FALSE,
           full.names = TRUE, recursive = FALSE, 
           ignore.case = FALSE, include.dirs = FALSE, no.. = TRUE)

FileName2 <- list.files(path = fastq_location, pattern = '_R2.fastq.gz', all.files = FALSE,
           full.names = TRUE, recursive = FALSE, 
           ignore.case = FALSE, include.dirs = FALSE, no.. = TRUE)

SampleName <- substring(basename(FileName1),1, nchar(basename(FileName1))-12)
#sample_names <- all_sample_names[seq(1, length(all_sample_names), 2)]

sampleSheet <- data.frame(FileName1, FileName2, SampleName) 
sampleSheet2 <- sampleSheet[1:2,]

# use e.g. 8 cores for alignment by creating a cluster object (from package parallel) and provide it to the qAlign function
#BiocManager::install("tictoc")
library(tictoc)
tic("makeCluster")
clus <- makeCluster(32)
toc()  # 42 sec

tic("align reads")

#For all samples
#align_Rhisat_split <- qAlign(sampleFile = sampleSheet, 
#               genome = read.delim("/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa"),
#               aligner = "Rhisat2", splicedAlignment = TRUE,
#               alignmentsDir = paste0(path_inDir, '/intron_analysis_qA_last'),
#               geneAnnotation = txHu,
#               clObj=clus)

#For 1 sample
sampleSheet <- data.frame(FileName1, FileName2, SampleName)
align_Rhisat_split <- qAlign(sampleFile = sampleSheet2,
               genome = read.delim("/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa"),
               aligner = "Rhisat2", splicedAlignment = TRUE,
               alignmentsDir = paste0(path_inDir, '/intron_analysis_qA_last'),
               geneAnnotation = txHu,
               clObj=clus)

stopCluster(clus)
rm(clus)
toc()


save(align_Rhisat_split, paste0(path_inDir, '/intron_analysis_qA_last/align_Rhisat_split'))

#write.table(align_Rhisat_split, paste0(path_inDir, '/intron_analysis_qA_last/align_Rhisat_split'), sep="\t", row.names=FALSE)

