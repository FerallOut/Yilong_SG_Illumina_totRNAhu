#!/bin/sh
# properties = {"wildcards": {}, "threads": 50, "rule": "multiBigwigSummary", "output": ["09_multiQC/without.duplicates.multiBigwigSummary.pdf"], "local": false, "log": ["09_multiQC/multiBigwigSummary.log"], "type": "single", "jobid": 1, "input": ["05_bigwigs/without_duplicates/DHX9_WT_rep1.bw", "05_bigwigs/without_duplicates/DHX9_WT_rep2.bw", "05_bigwigs/without_duplicates/DHX9_WT_rep3.bw", "05_bigwigs/without_duplicates/DHX9_UV_rep1.bw", "05_bigwigs/without_duplicates/DHX9_UV_rep2.bw", "05_bigwigs/without_duplicates/DHX9_UV_rep3.bw"], "params": {"outdir": "09_multiQC"}, "cluster": {}, "resources": {}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake 09_multiQC/without.duplicates.multiBigwigSummary.pdf 09_multiQC/multiBigwigSummary.log --snakefile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.7yld784h 05_bigwigs/without_duplicates/DHX9_WT_rep1.bw 05_bigwigs/without_duplicates/DHX9_WT_rep2.bw 05_bigwigs/without_duplicates/DHX9_WT_rep3.bw 05_bigwigs/without_duplicates/DHX9_UV_rep1.bw 05_bigwigs/without_duplicates/DHX9_UV_rep2.bw 05_bigwigs/without_duplicates/DHX9_UV_rep3.bw --latency-wait 100 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
 --configfile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/example_config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules multiBigwigSummary  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.7yld784h/1.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.7yld784h/1.jobfailed"; exit 1)

