#!/bin/sh
# properties = {"type": "single", "rule": "FeatureCountConstitutiveExons", "local": false, "input": ["RawData/03aMappingSTARRscript/DHX9_WT_rep3.bam", "ProcessedData/AnnotationObjects/species.database.constitutive.exons.gtf"], "output": ["RawData/CountFiles/ConstitutiveExons/DHX9_WT_rep3.tabular"], "wildcards": {"base": "DHX9_WT_rep3"}, "params": {"input": "RawData/03aMappingSTARRscript/DHX9_WT_rep3.bam"}, "log": [], "threads": 1, "resources": {}, "jobid": 15, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/home/suny/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake RawData/CountFiles/ConstitutiveExons/DHX9_WT_rep3.tabular --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.d28fkbbj RawData/03aMappingSTARRscript/DHX9_WT_rep3.bam ProcessedData/AnnotationObjects/species.database.constitutive.exons.gtf /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/05ad4773 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules FeatureCountConstitutiveExons --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.d28fkbbj/15.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.d28fkbbj/15.jobfailed"; exit 1)

