#!/bin/sh
# properties = {"type": "single", "rule": "ReadStatisticsFirstPython", "local": false, "input": ["RawData/03bMappingSTARPython/DHX9_UV_rep3.bam", "ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_UV_rep3.filtered.bam"], "output": ["Output/02bReadStatisticsSTARPython/DHX9_UV_rep3.without.duplicates.txt"], "wildcards": {"base": "DHX9_UV_rep3"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 87, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/home/suny/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/02bReadStatisticsSTARPython/DHX9_UV_rep3.without.duplicates.txt --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.c8er7om1 RawData/03bMappingSTARPython/DHX9_UV_rep3.bam ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_UV_rep3.filtered.bam /home/suny/miniconda3/envs/snakeRNAPipes/370c99c6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules ReadStatisticsFirstPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /home/suny/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.c8er7om1/87.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.c8er7om1/87.jobfailed"; exit 1)

