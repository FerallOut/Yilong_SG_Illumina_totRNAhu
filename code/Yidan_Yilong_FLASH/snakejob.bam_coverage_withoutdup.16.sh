#!/bin/sh
# properties = {"cluster": {}, "resources": {}, "jobid": 16, "threads": 20, "input": ["04_removedup/03_rm_events/DHX9_UV_rep3.filtered.bam.bai", "04_removedup/03_rm_events/DHX9_UV_rep3.filtered.bam"], "local": false, "wildcards": {"base": "DHX9_UV_rep3"}, "log": ["05_bigwigs/without_duplicates/Logs/DHX9_UV_rep3.bamCoverage.log"], "params": {}, "output": ["05_bigwigs/without_duplicates/DHX9_UV_rep3.bw"], "type": "single", "rule": "bam_coverage_withoutdup"}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake 05_bigwigs/without_duplicates/DHX9_UV_rep3.bw 05_bigwigs/without_duplicates/Logs/DHX9_UV_rep3.bamCoverage.log --snakefile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.hlv29kiz 04_removedup/03_rm_events/DHX9_UV_rep3.filtered.bam.bai 04_removedup/03_rm_events/DHX9_UV_rep3.filtered.bam --latency-wait 100 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
 --configfile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/example_config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules bam_coverage_withoutdup  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.hlv29kiz/16.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.hlv29kiz/16.jobfailed"; exit 1)

