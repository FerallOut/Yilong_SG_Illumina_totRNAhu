#!/bin/sh
# properties = {"cluster": {}, "wildcards": {"base": "DHX9_WT_rep2"}, "type": "single", "input": ["03_mapping/DHX9_WT_rep2.bam"], "log": ["05_bigwigs/with_duplicates/Logs/DHX9_WT_rep2.bamCoverage.log"], "output": ["05_bigwigs/with_duplicates/DHX9_WT_rep2.bw"], "rule": "bam_coverage", "jobid": 10, "resources": {}, "threads": 20, "params": {}, "local": false}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake 05_bigwigs/with_duplicates/DHX9_WT_rep2.bw 05_bigwigs/with_duplicates/Logs/DHX9_WT_rep2.bamCoverage.log --snakefile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.ropcw3io 03_mapping/DHX9_WT_rep2.bam --latency-wait 100 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
 --configfile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/example_config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules bam_coverage  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.ropcw3io/10.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.ropcw3io/10.jobfailed"; exit 1)

