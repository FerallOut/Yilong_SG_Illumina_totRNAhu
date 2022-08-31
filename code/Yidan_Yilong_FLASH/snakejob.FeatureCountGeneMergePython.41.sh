#!/bin/sh
# properties = {"type": "single", "rule": "FeatureCountGeneMergePython", "local": false, "input": ["ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep3.filtered.bam", "ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.gtf"], "output": ["ProcessedData/04bCountFilesSTARPython/GeneMerge/DHX9_WT_rep3.tabular"], "wildcards": {"base": "DHX9_WT_rep3"}, "params": {"input": "ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep3.filtered.bam"}, "log": [], "threads": 20, "resources": {}, "jobid": 41, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake ProcessedData/04bCountFilesSTARPython/GeneMerge/DHX9_WT_rep3.tabular --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6 ProcessedData/01bRemoveDuplicatesSTARPython/DHX9_WT_rep3.filtered.bam ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.gtf /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/7abd8e75 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/FLASH-seq.config.yaml  --allowed-rules FeatureCountGeneMergePython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6/41.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2020FlashHumanhnRNPMuvCyto/.snakemake/tmp.gs3gfsm6/41.jobfailed"; exit 1)
