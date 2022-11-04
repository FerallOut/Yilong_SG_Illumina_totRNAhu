#!/bin/sh
# properties = {"type": "single", "rule": "PeaksCallingPeakachuRscript", "local": false, "input": ["ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam.bai"], "output": ["ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT_rep1/peaks.bed"], "wildcards": {"base": "DHX9_WT_rep1"}, "params": {"sampleinfo": "/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/sampleInfo.tsv", "output_dir": "ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT_rep1/"}, "log": ["ProcessedData/03aPeakCallingSTARPeakachuRscript/logs/tss.DHX9_WT_rep1.log"], "threads": 20, "resources": {}, "jobid": 29, "cluster": {"memory": "30G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/home/suny/miniconda3/bin/python3.6 \
-m snakemake ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT_rep1/peaks.bed --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.tf6dusg0 ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam.bai --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/FLASH-seq.config.yaml  --nocolor \
--notemp --no-hooks --nolock --mode 2  --use-conda  --conda-prefix /package/anaconda3/envs/  --allowed-rules PeaksCallingPeakachuRscript  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.tf6dusg0/29.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.tf6dusg0/29.jobfailed"; exit 1)

