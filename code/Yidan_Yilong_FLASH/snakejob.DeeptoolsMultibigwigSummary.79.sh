#!/bin/sh
# properties = {"type": "single", "rule": "DeeptoolsMultibigwigSummary", "local": false, "input": ["ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep1.bw", "ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep1.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep2.bw", "ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep2.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw", "ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep3.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep1.bw", "ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep1.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep2.bw", "ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep2.bw", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep3.bw", "ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep3.bw"], "output": ["Output/04bDeeptoolsSTARNoduplicates/multiBigwigSummary.read.coverage.spearman.pdf"], "wildcards": {}, "params": {"labels": ["ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep1", "ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep1", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep2", "ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep2", "ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3", "ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep3", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep1", "ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep1", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep2", "ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep2", "ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep3", "ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep3"], "outdir": "Output/04bDeeptoolsSTARNoduplicates"}, "log": ["Output/04bDeeptoolsSTARNoduplicates/logs/multiBigwigSummary.log"], "threads": 50, "resources": {}, "jobid": 79, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/04bDeeptoolsSTARNoduplicates/multiBigwigSummary.read.coverage.spearman.pdf --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.ewapzbb0 ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep1.bw ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep1.bw ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep2.bw ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep2.bw ProcessedData/02aBigwigsSTARRscript/DHX9_WT_rep3.bw ProcessedData/02bBigwigsSTARPython/DHX9_WT_rep3.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep1.bw ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep1.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep2.bw ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep2.bw ProcessedData/02aBigwigsSTARRscript/DHX9_UV_rep3.bw ProcessedData/02bBigwigsSTARPython/DHX9_UV_rep3.bw /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/f1b063b6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/FLASH-seq.config.yaml  --allowed-rules DeeptoolsMultibigwigSummary --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.ewapzbb0/79.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.ewapzbb0/79.jobfailed"; exit 1)
