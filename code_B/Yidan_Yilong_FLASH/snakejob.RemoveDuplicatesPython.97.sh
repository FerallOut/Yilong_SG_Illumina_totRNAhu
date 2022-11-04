#!/bin/sh
# properties = {"type": "single", "rule": "RemoveDuplicatesPython", "local": false, "input": ["RawData/03bMappingSTARPython/DHX9_WT_rep1.bam", "RawData/01bFastqTrimBarcode/20190410hela_endoDHX9_FLASH.barcodeXN.fastq"], "output": ["ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep1.filtered.bed", "ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep1.filtered.bam"], "wildcards": {"base": "DHX9_WT_rep1"}, "params": {"sam": "RawData/03bMappingSTARPython/DHX9_WT_rep1.sam", "aln_end_dir": "ProcessedData/01bRemoveDuplicatesSTARPython/01_aln_end/", "aln_end": "ProcessedData/01bRemoveDuplicatesSTARPython/01_aln_end/DHX9_WT_rep1.bed", "merge_duplicates_dir": "ProcessedData/01bRemoveDuplicatesSTARPython/02_merge_duplicates/", "merge_duplicates": "ProcessedData/01bRemoveDuplicatesSTARPython/02_merge_duplicates/DHX9_WT_rep1.bed", "genome_chr_size": "/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.chrom.sizes"}, "log": ["ProcessedData/01bRemoveDuplicatesSTARPython/Log/DHX9_WT_rep1.log"], "threads": 10, "resources": {}, "jobid": 97, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/home/suny/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep1.filtered.bam --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.c8er7om1 RawData/03bMappingSTARPython/DHX9_WT_rep1.bam RawData/01bFastqTrimBarcode/20190410hela_endoDHX9_FLASH.barcodeXN.fastq /home/suny/miniconda3/envs/snakeRNAPipes/370c99c6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules RemoveDuplicatesPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /home/suny/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.c8er7om1/97.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.c8er7om1/97.jobfailed"; exit 1)

