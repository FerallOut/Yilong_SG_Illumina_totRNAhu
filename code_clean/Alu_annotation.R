#make GRanges
loc <- read.table("/data/akhtar/group3/qian/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/AllGenes/all.pairDis.txt", 
                  header = TRUE)

library(dplyr)
Dis_300 <- filter(loc, loc$Dis <= 300)

Dis_300_a_bed <- data.frame(Dis_300$chr, Dis_300$as, Dis_300$ae, Dis_300$stranda)
Dis_300_b_bed <- data.frame(Dis_300$chr, Dis_300$bs, Dis_300$be, Dis_300$strandb)

colnames(Dis_300_a_bed) <- c("chr", "start", "end", "strand")
colnames(Dis_300_b_bed) <- c("chr", "start", "end", "strand")

library(GenomicRanges)
Dis_300_a_GRanges <- makeGRangesFromDataFrame(Dis_300_a_bed, ignore.strand = TRUE)
Dis_300_b_GRanges <- makeGRangesFromDataFrame(Dis_300_b_bed, ignore.strand = TRUE)

#make TxDb
library(GenomicFeatures)
txdb <- makeTxDbFromGFF(file="/data/akhtar/group3/qian/Projects/Ref/genes.gtf",
                        organism="Homo sapiens")

txbygene <- transcriptsBy(txdb, "gene")

olap_a_300 <- findOverlaps(Dis_300_a_GRanges, txbygene, type = "within")
olap_b_300 <- findOverlaps(Dis_300_b_GRanges, txbygene, type = "within")

names_a_olap_300 <- data.frame(gene_id = names(txbygene[subjectHits(olap_a_300)]))
names_b_olap_300 <- data.frame(gene_id = names(txbygene[subjectHits(olap_b_300)]))


names_a_olap_300 <- data.frame(gene_id = names(txbygene[subjectHits(olap_a_300)])) %>% 
  group_by(gene_id) %>% 
  summarise(n = n())

names_b_olap_300 <- data.frame(gene_id = names(txbygene[subjectHits(olap_b_300)])) %>% 
  group_by(gene_id) %>% 
  summarise(n = n())

names_olap_300 <- merge(names_a_olap_300, names_b_olap_300, by = "gene_id")
names_olap_300 <- names_olap_300[, 1:2]

length_300 <- getBM(attributes = c("ensembl_gene_id","start_position", "end_position"),
                     filters = 'ensembl_gene_id',
                     values = names_olap_300$gene_id,
                     mart = ensembl_91)

gene_length_300 <- merge(names_olap_300, length_300, by.x = "gene_id", by.y = "ensembl_gene_id")

gene_length_300$length <- gene_length_300$end_position - gene_length_300$start_position

write.table(gene_length_300, "/data/akhtar/group2/zhao/zhou/Alu/Dis_500_loop_number.txt", sep = "\t", row.names = F)


library(xlsx)
SG_gene <- read.xlsx("/data/akhtar/group2/zhao/zhou/gene_list/gene_list.xlsx", sheetIndex = 1, header = F)

SG_loop_300 <- merge(SG_gene, gene_length_300, by.x = "X1", by.y = "gene_id")
write.table(SG_loop_300, "/data/akhtar/group2/zhao/zhou/Alu/Dis_300_SG_loop_number.txt", sep = "\t", row.names = F)
