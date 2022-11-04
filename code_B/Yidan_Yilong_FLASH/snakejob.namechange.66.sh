#!/bin/sh
# properties = {"type": "single", "rule": "namechange", "local": false, "input": ["/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R1.fastq.gz", "/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R2.fastq.gz"], "output": ["RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R1.fastq.gz", "RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R2.fastq.gz"], "wildcards": {"sample": "20190410hela_endoDHX9_FLASH"}, "params": {"tmp1": "RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R1_val_1.fq.gz", "tmp2": "RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R2_val_2.fq.gz", "opts": "", "output_dir": "RawData/01aFastqTrimAdapter/"}, "log": [], "threads": 1, "resources": {}, "jobid": 66, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/home/suny/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake RawData/01aFastqTrimAdapter/20190410hela_endoDHX9_FLASH_R1.fastq.gz --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.j98frsib /data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R1.fastq.gz /data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/20190410hela_endoDHX9_FLASH_R2.fastq.gz /home/suny/miniconda3/envs/snakeRNAPipes/371fec85 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules namechange --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /home/suny/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.j98frsib/66.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.j98frsib/66.jobfailed"; exit 1)

