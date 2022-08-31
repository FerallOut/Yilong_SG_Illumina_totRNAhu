#!/bin/sh
# properties = {"type": "single", "rule": "FeatureCountGeneOriginalRscript", "local": false, "input": ["ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep3.filtered.bam", "/data/repository/organisms/GRCh38_ensembl/gencode/release_27/genes.gtf"], "output": ["ProcessedData/04aCountFilesSTARRscript/GeneOriginal/DHX9_UV_rep3.tabular"], "wildcards": {"base": "DHX9_UV_rep3"}, "params": {"input": "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep3.filtered.bam"}, "log": [], "threads": 5, "resources": {}, "jobid": 14, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake ProcessedData/04aCountFilesSTARRscript/GeneOriginal/DHX9_UV_rep3.tabular --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep3.filtered.bam /data/repository/organisms/GRCh38_ensembl/gencode/release_27/genes.gtf /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/7abd8e75 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules FeatureCountGeneOriginalRscript --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/14.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/14.jobfailed"; exit 1)

