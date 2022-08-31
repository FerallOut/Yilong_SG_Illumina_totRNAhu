#!/bin/sh
# properties = {"type": "single", "rule": "ReadStatisticsSecondRscript", "local": false, "input": ["ProcessedData/03aPeakCallingSTARPureclipRscript/DHX9_WT/peaks.bed", "ProcessedData/03aPeakCallingSTARPureclipRscript/DHX9_UV/peaks.bed", "ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed"], "output": ["Output/02aReadStatisticsSTARRscript/total.peaks.statistics.txt"], "wildcards": {}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 59, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/02aReadStatisticsSTARRscript/total.peaks.statistics.txt --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.qt28ed8z ProcessedData/03aPeakCallingSTARPureclipRscript/DHX9_WT/peaks.bed ProcessedData/03aPeakCallingSTARPureclipRscript/DHX9_UV/peaks.bed ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03aPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/eeac4364 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/FLASH-seq.config.yaml  --allowed-rules ReadStatisticsSecondRscript --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.qt28ed8z/59.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.qt28ed8z/59.jobfailed"; exit 1)

