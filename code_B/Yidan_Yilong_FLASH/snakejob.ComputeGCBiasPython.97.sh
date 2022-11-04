#!/bin/sh
# properties = {"type": "single", "rule": "ComputeGCBiasPython", "local": false, "input": ["RawData/03bMappingSTARPython/DHX9_WT_rep1.bam", "RawData/03bMappingSTARPython/DHX9_WT_rep1.bam.bai"], "output": ["Output/03bComputeGCBiasSTARPython/DHX9_WT_rep1.filtered.GCBias.png", "Output/03bComputeGCBiasSTARPython/DHX9_WT_rep1.filtered.GCBias.freq.tsv"], "wildcards": {"base": "DHX9_WT_rep1"}, "params": {"paired": true, "genome_size": 2900338458, "genome_2bit": "/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.2bit", "blacklist": "--blackListFileName /data/repository/organisms/GRCh38_ensembl/akundaje/blacklist.UseMe.bed", "median_fragment_length": "", "sampleSize": 10000000}, "log": ["Output/03bComputeGCBiasSTARPython/logs/computeGCBias.DHX9_WT_rep1.filtered.out", "Output/03bComputeGCBiasSTARPython/logs/computeGCBias.DHX9_WT_rep1.filtered.err"], "threads": 50, "resources": {}, "jobid": 97, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake Output/03bComputeGCBiasSTARPython/DHX9_WT_rep1.filtered.GCBias.png --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l RawData/03bMappingSTARPython/DHX9_WT_rep1.bam RawData/03bMappingSTARPython/DHX9_WT_rep1.bam.bai /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/f1b063b6 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules ComputeGCBiasPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/97.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/97.jobfailed"; exit 1)

