#!/bin/sh
# properties = {"cluster": {"memory": "6G"}, "threads": 50, "wildcards": {}, "input": ["ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep1.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep2.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep1.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep2.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep3.bw"], "output": ["Output/02aReplicatesSTARRscript/without.duplicates.multiBigwigSummary.pdf"], "jobid": 7, "rule": "multiBigwigSummaryRscript", "type": "single", "params": {"outdir": "Output/02aReplicatesSTARRscript"}, "log": ["Output/02aReplicatesSTARRscript/multiBigwigSummary.log"], "local": false, "resources": {}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake Output/02aReplicatesSTARRscript/without.duplicates.multiBigwigSummary.pdf Output/02aReplicatesSTARRscript/multiBigwigSummary.log --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.df96rw2j ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep1.bw ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep2.bw ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep1.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep2.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep3.bw --latency-wait 300 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules multiBigwigSummaryRscript  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.df96rw2j/7.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.df96rw2j/7.jobfailed"; exit 1)

