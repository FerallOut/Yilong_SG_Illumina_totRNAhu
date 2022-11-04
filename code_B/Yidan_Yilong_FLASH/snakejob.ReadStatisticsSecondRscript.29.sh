#!/bin/sh
# properties = {"type": "single", "rule": "ReadStatisticsSecondRscript", "local": false, "input": ["ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT/peaks.bed", "ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_UV/peaks.bed", "ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed"], "output": ["Output/02aReadStatisticsSTARRscript/total.peaks.statistics.txt"], "wildcards": {}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 29, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/02aReadStatisticsSTARRscript/total.peaks.statistics.txt --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp._qh8rkkh ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT/peaks.bed ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_UV/peaks.bed ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/e124a57d --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/FLASH-seq.config.yaml  --allowed-rules ReadStatisticsSecondRscript --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp._qh8rkkh/29.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp._qh8rkkh/29.jobfailed"; exit 1)

