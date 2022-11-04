#!/bin/sh
# properties = {"type": "single", "rule": "PeaksCallingPeakachuRscript", "local": false, "input": ["ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep2.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam"], "output": ["ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT/peaks.bed"], "wildcards": {"group": "DHX9_WT"}, "params": {"sampleinfo": "/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/sampleInfo.tsv", "fold_change": "2.5", "output_dir": "ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT/"}, "log": ["ProcessedData/03aPeakCallingSTARPeakachuRscript/logs/tss.DHX9_WT.log"], "threads": 20, "resources": {}, "jobid": 79, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/home/suny/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake ProcessedData/03aPeakCallingSTARPeakachuRscript/DHX9_WT/peaks.bed --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.8y0ix5rc ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep2.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam /home/suny/miniconda3/envs/snakeRNAPipes/370c99c6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules PeaksCallingPeakachuRscript --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /home/suny/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.8y0ix5rc/79.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.8y0ix5rc/79.jobfailed"; exit 1)

