#!/bin/sh
# properties = {"type": "single", "rule": "ReadStatisticsFirstPython", "local": false, "input": ["RawData/03bMappingSTARPython/DHX9_WT_rep3.bam", "ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep3.filtered.bam"], "output": ["Output/02bReadStatisticsSTARPython/DHX9_WT_rep3.without.duplicates.txt"], "wildcards": {"base": "DHX9_WT_rep3"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 148, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/02bReadStatisticsSTARPython/DHX9_WT_rep3.without.duplicates.txt --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6 RawData/03bMappingSTARPython/DHX9_WT_rep3.bam ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep3.filtered.bam /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/eeac4364 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/FLASH-seq.config.yaml  --allowed-rules ReadStatisticsFirstPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6/148.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6/148.jobfailed"; exit 1)

