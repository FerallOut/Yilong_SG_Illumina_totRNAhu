#!/bin/sh
# properties = {"cluster": {}, "resources": {}, "jobid": 25, "threads": 10, "input": ["03_mapping/DHX9_WT_rep3.bam", "01_fastq/barcode_trimmed/barcodeXN.fastq"], "local": false, "wildcards": {"base": "DHX9_WT_rep3"}, "log": ["04_removedup/Log/DHX9_WT_rep3.log"], "params": {"merge_duplicates_dir": "04_removedup/02_merge_duplicates/", "merge_duplicates": "04_removedup/02_merge_duplicates/DHX9_WT_rep3.bed", "sam": "03_mapping/DHX9_WT_rep3.sam", "aln_end": "04_removedup/01_aln_end/DHX9_WT_rep3.bed", "aln_end_dir": "04_removedup/01_aln_end/", "genome": "/data/repository/organisms/GRCh38_ensembl"}, "output": ["04_removedup/03_rm_events/DHX9_WT_rep3.filtered.bed", "04_removedup/03_rm_events/DHX9_WT_rep3.filtered.bam"], "type": "single", "rule": "remove_dup"}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake 04_removedup/03_rm_events/DHX9_WT_rep3.filtered.bed 04_removedup/03_rm_events/DHX9_WT_rep3.filtered.bam 04_removedup/Log/DHX9_WT_rep3.log --snakefile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.hlv29kiz 03_mapping/DHX9_WT_rep3.bam 01_fastq/barcode_trimmed/barcodeXN.fastq --latency-wait 100 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
 --configfile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/example_config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules remove_dup  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.hlv29kiz/25.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.hlv29kiz/25.jobfailed"; exit 1)

