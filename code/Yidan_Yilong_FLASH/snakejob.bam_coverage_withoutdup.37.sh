#!/bin/sh
# properties = {"wildcards": {"base": "DHX9_WT_rep1"}, "output": ["05_bigwigs/without_duplicates/DHX9_WT_rep1.bw"], "type": "single", "input": ["04_removedup/03_rm_events/DHX9_WT_rep1.filtered.bam", "04_removedup/03_rm_events/DHX9_WT_rep1.filtered.bam.bai"], "params": {}, "threads": 20, "cluster": {}, "resources": {}, "local": false, "rule": "bam_coverage_withoutdup", "log": ["05_bigwigs/without_duplicates/Logs/DHX9_WT_rep1.bamCoverage.log"], "jobid": 37}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake 05_bigwigs/without_duplicates/DHX9_WT_rep1.bw 05_bigwigs/without_duplicates/Logs/DHX9_WT_rep1.bamCoverage.log --snakefile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.wiv6go_2 04_removedup/03_rm_events/DHX9_WT_rep1.filtered.bam 04_removedup/03_rm_events/DHX9_WT_rep1.filtered.bam.bai --latency-wait 100 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
 --configfile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/example_config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules bam_coverage_withoutdup  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.wiv6go_2/37.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.wiv6go_2/37.jobfailed"; exit 1)

