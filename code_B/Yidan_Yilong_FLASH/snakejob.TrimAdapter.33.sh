#!/bin/sh
# properties = {"type": "single", "resources": {}, "input": ["/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R1.fastq.gz", "/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R2.fastq.gz"], "threads": 1, "log": [], "rule": "TrimAdapter", "output": ["RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R1.fastq.gz", "RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R2.fastq.gz"], "wildcards": {}, "local": false, "params": {"opts": "", "tmp2": ["RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R2_val_2.fq.gz"], "output_dir": "RawData/01aFastqTrimAdapter/", "tmp1": ["RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R1_val_1.fq.gz"]}, "jobid": 33, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R1.fastq.gz RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R2.fastq.gz --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.v0bgqte9 /data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R1.fastq.gz /data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R2.fastq.gz --latency-wait 300 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules TrimAdapter  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.v0bgqte9/33.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.v0bgqte9/33.jobfailed"; exit 1)

