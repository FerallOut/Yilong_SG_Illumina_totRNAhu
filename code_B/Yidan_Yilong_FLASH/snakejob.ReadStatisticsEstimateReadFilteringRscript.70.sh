#!/bin/sh
# properties = {"type": "single", "rule": "ReadStatisticsEstimateReadFilteringRscript", "local": false, "input": ["RawData/03aMappingSTARRscript/DHX9_UV_rep2.bam"], "output": ["Output/02aReadStatisticsSTARRscript/DHX9_UV_rep2.filtering.estimation.txt"], "wildcards": {"base": "DHX9_UV_rep2"}, "params": {}, "log": ["Output/02aReadStatisticsSTARRscript/logs/DHX9_UV_rep2.estimateReadFiltering.out", "Output/02aReadStatisticsSTARRscript/logs/DHX9_UV_rep2.estimateReadFiltering.err"], "threads": 1, "resources": {}, "jobid": 70, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/02aReadStatisticsSTARRscript/DHX9_UV_rep2.filtering.estimation.txt --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6 RawData/03aMappingSTARRscript/DHX9_UV_rep2.bam /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/f1b063b6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/FLASH-seq.config.yaml  --allowed-rules ReadStatisticsEstimateReadFilteringRscript --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6/70.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6/70.jobfailed"; exit 1)

