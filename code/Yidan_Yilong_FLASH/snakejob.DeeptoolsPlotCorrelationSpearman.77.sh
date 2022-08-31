#!/bin/sh
# properties = {"type": "single", "rule": "DeeptoolsPlotCorrelationSpearman", "local": false, "input": ["Output/04bDeeptoolsSTARNoduplicates/multiBamSummary.read.coverage.bins.npz"], "output": ["Output/04bDeeptoolsSTARNoduplicates/multiBamSummary.read.coverage.spearman.tsv"], "wildcards": {}, "params": {"plotcmd": "--plotFile Output/04bDeeptoolsSTARNoduplicates/multiBamSummary.read.coverage.spearman.pdf", "title": "fragment"}, "log": ["Output/04bDeeptoolsSTARNoduplicates/logs/PlotCorrelationSpearman.out", "Output/04bDeeptoolsSTARNoduplicates/logs/PlotCorrelationSpearman.err"], "threads": 1, "resources": {}, "jobid": 77, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/04bDeeptoolsSTARNoduplicates/multiBamSummary.read.coverage.spearman.tsv --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.ewapzbb0 Output/04bDeeptoolsSTARNoduplicates/multiBamSummary.read.coverage.bins.npz /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/f1b063b6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/FLASH-seq.config.yaml  --allowed-rules DeeptoolsPlotCorrelationSpearman --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.ewapzbb0/77.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvCytoFirstPairs/.snakemake/tmp.ewapzbb0/77.jobfailed"; exit 1)

