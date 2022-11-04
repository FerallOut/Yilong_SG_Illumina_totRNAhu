#!/bin/sh
# properties = {"type": "single", "rule": "FeatureCountGeneMerge", "local": false, "input": ["RawData/03aMappingSTARRscript/DHX9_WT_rep1.bam", "ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.gtf"], "output": ["RawData/CountFiles/GeneMerge/DHX9_WT_rep1.tabular"], "wildcards": {"base": "DHX9_WT_rep1"}, "params": {"input": "RawData/03aMappingSTARRscript/DHX9_WT_rep1.bam"}, "log": [], "threads": 1, "resources": {}, "jobid": 7, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/home/suny/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake RawData/CountFiles/GeneMerge/DHX9_WT_rep1.tabular --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.d28fkbbj RawData/03aMappingSTARRscript/DHX9_WT_rep1.bam ProcessedData/AnnotationObjects/database.version.annotation.merge.transcript.region.gtf /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/05ad4773 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules FeatureCountGeneMerge --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.d28fkbbj/7.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.d28fkbbj/7.jobfailed"; exit 1)

