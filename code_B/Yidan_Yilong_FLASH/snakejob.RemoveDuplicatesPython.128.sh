#!/bin/sh
# properties = {"type": "single", "rule": "RemoveDuplicatesPython", "local": false, "input": ["RawData/03bMappingSTARPython/DHX9_UV_rep3.bam", "RawData/01bFastqTrimBarcode/unknown.barcodeXN.fastq"], "output": ["ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_UV_rep3.filtered.bed", "ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_UV_rep3.filtered.bam"], "wildcards": {"base": "DHX9_UV_rep3"}, "params": {"sam": "RawData/03bMappingSTARPython/DHX9_UV_rep3.sam", "aln_end_dir": "ProcessedData/01bRemoveDuplicatesSTARPython/01_aln_end/", "aln_end": "ProcessedData/01bRemoveDuplicatesSTARPython/01_aln_end/DHX9_UV_rep3.bed", "merge_duplicates_dir": "ProcessedData/01bRemoveDuplicatesSTARPython/02_merge_duplicates/", "merge_duplicates": "ProcessedData/01bRemoveDuplicatesSTARPython/02_merge_duplicates/DHX9_UV_rep3.bed", "genome_chr_size": "/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.chrom.sizes"}, "log": ["ProcessedData/01bRemoveDuplicatesSTARPython/Log/DHX9_UV_rep3.log"], "threads": 10, "resources": {}, "jobid": 128, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_UV_rep3.filtered.bam --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.jao73_0x RawData/03bMappingSTARPython/DHX9_UV_rep3.bam RawData/01bFastqTrimBarcode/unknown.barcodeXN.fastq /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/e124a57d --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/FLASH-seq.config.yaml  --allowed-rules RemoveDuplicatesPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.jao73_0x/128.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.jao73_0x/128.jobfailed"; exit 1)

