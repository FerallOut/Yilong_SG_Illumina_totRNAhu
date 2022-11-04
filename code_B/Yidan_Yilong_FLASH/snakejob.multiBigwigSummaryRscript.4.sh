#!/bin/sh
# properties = {"type": "single", "rule": "multiBigwigSummaryRscript", "local": false, "input": ["ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep1.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep2.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep1.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep2.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep3.bw"], "output": ["Output/02aReplicatesSTARRscript/without.duplicates.multiBigwigSummary.pdf"], "wildcards": {}, "params": {"outdir": "Output/02aReplicatesSTARRscript"}, "log": ["Output/02aReplicatesSTARRscript/multiBigwigSummary.log"], "threads": 100, "resources": {}, "jobid": 4, "cluster": {"memory": "30G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/home/suny/miniconda3/bin/python3.6 \
-m snakemake Output/02aReplicatesSTARRscript/without.duplicates.multiBigwigSummary.pdf --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.4q_vwkxj ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep1.bw ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep2.bw ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep1.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep2.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep3.bw --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/FLASH-seq.config.yaml  --nocolor \
--notemp --no-hooks --nolock --mode 2  --use-conda  --conda-prefix /package/anaconda3/envs/  --allowed-rules multiBigwigSummaryRscript  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.4q_vwkxj/4.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.4q_vwkxj/4.jobfailed"; exit 1)

