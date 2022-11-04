#!/bin/sh
# properties = {"type": "single", "rule": "BigwigsRscript", "local": false, "input": ["ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam.bai"], "output": ["ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw"], "wildcards": {"base": "DHX9_WT_rep3"}, "params": {}, "log": ["ProcessedData/02aBigwigsSTARRscript/Logs/DHX9_WT_rep3.bamCoverage.log"], "threads": 20, "resources": {}, "jobid": 19, "cluster": {"memory": "30G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/home/suny/miniconda3/bin/python3.6 \
-m snakemake ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.tf6dusg0 ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam.bai --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/FLASH-seq.config.yaml  --nocolor \
--notemp --no-hooks --nolock --mode 2  --use-conda  --conda-prefix /package/anaconda3/envs/  --allowed-rules BigwigsRscript  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.tf6dusg0/19.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.tf6dusg0/19.jobfailed"; exit 1)

