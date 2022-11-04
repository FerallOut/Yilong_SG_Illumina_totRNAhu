#!/bin/sh
# properties = {"type": "single", "rule": "ReadStatisticsEstimateReadFilteringPython", "local": false, "input": ["RawData/03bMappingSTARPython/DHX9_UV_rep3.bam"], "output": ["Output/02bReadStatisticsSTARPython/DHX9_UV_rep3.filtering.estimation.txt"], "wildcards": {"base": "DHX9_UV_rep3"}, "params": {}, "log": ["Output/02bReadStatisticsSTARPython/logs/DHX9_UV_rep3.estimateReadFiltering.out", "Output/02bReadStatisticsSTARPython/logs/DHX9_UV_rep3.estimateReadFiltering.err"], "threads": 1, "resources": {}, "jobid": 90, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/02bReadStatisticsSTARPython/DHX9_UV_rep3.filtering.estimation.txt --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l RawData/03bMappingSTARPython/DHX9_UV_rep3.bam /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/f1b063b6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules ReadStatisticsEstimateReadFilteringPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/90.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/90.jobfailed"; exit 1)

