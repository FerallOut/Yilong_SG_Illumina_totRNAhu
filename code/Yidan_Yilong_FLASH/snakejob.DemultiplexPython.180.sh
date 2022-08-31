#!/bin/sh
# properties = {"type": "single", "rule": "DemultiplexPython", "local": false, "input": ["RawData/01bFastqTrimBarcodeReadName/20190410hela_endoDHX9_FLASH_R1.fastq.gz", "RawData/01bFastqTrimBarcodeReadName/20190410hela_endoDHX9_FLASH_R2.fastq.gz"], "output": ["RawData/02bSplittingPython/DHX9_WT_rep1_R1.fastq.gz", "RawData/02bSplittingPython/DHX9_WT_rep2_R1.fastq.gz", "RawData/02bSplittingPython/DHX9_WT_rep3_R1.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep1_R1.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep2_R1.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep3_R1.fastq.gz", "RawData/02bSplittingPython/DHX9_WT_rep1_R2_tmp.fastq.gz", "RawData/02bSplittingPython/DHX9_WT_rep2_R2_tmp.fastq.gz", "RawData/02bSplittingPython/DHX9_WT_rep3_R2_tmp.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep1_R2_tmp.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep2_R2_tmp.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep3_R2_tmp.fastq.gz"], "wildcards": {}, "params": {"r2": ["RawData/02bSplittingPython/DHX9_WT_rep1_R2.fastq.gz", "RawData/02bSplittingPython/DHX9_WT_rep2_R2.fastq.gz", "RawData/02bSplittingPython/DHX9_WT_rep3_R2.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep1_R2.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep2_R2.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep3_R2.fastq.gz"], "sampleinfofa": "/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/barcode.fa", "indir": "RawData/01bFastqTrimBarcodeReadName", "outdir": "RawData/02bSplittingPython"}, "log": ["RawData/02bSplittingPython/Logs/demultiplex.python.log"], "threads": 20, "resources": {}, "jobid": 180, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake RawData/02bSplittingPython/DHX9_WT_rep1_R1.fastq.gz --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.n6pghxr2 RawData/01bFastqTrimBarcodeReadName/20190410hela_endoDHX9_FLASH_R1.fastq.gz RawData/01bFastqTrimBarcodeReadName/20190410hela_endoDHX9_FLASH_R2.fastq.gz /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/eeac4364 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules DemultiplexPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.n6pghxr2/180.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.n6pghxr2/180.jobfailed"; exit 1)
