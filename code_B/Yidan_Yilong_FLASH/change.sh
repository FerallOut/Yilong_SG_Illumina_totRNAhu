SlurmEasy -t 20 "CrossMap.py bed ~/sunyd/Genome/ChromosomeMappings/hg18ToHg38.over.chain GSM501710_HeLa_Pol3.hg18.bed hg38.GSM501710_HeLa_Pol3.hg18.bed"
SlurmEasy -t 20 "CrossMap.py bed ~/sunyd/Genome/ChromosomeMappings/hg18ToHg38.over.chain GSM501714_CD4_Pol3.hg18.bed hg38.GSM501714_CD4_Pol3.hg18.bed"
cut -f1-3,5 hg38.GSM501710_HeLa_Pol3.ensembl.bed |sort -k1,1 -k2,2n> hg38.GSM501710_HeLa_Pol3.ensembl.bedGraph
SlurmEasy "bedGraphToBigWig hg38.GSM501710_HeLa_Pol3.ensembl.bedGraph /data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.chrom.sizes hg38.GSM501710_HeLa_Pol3.ensembl.bw"
