#!/bin/sh
# properties = {"cluster": {}, "wildcards": {}, "type": "single", "input": ["01_fastq/adaptor_trimmed/fastqc/20190410hela_endoDHX9_FLASH_R1_fastqc.html", "01_fastq/adaptor_trimmed/fastqc/20190410hela_endoDHX9_FLASH_R2_fastqc.html", "01_fastq/adaptor_trimmed/20190410hela_endoDHX9_FLASH_R1.fastq.gz", "01_fastq/adaptor_trimmed/20190410hela_endoDHX9_FLASH_R2.fastq.gz", "03_mapping/DHX9_WT_rep1.bam", "03_mapping/DHX9_WT_rep2.bam", "03_mapping/DHX9_WT_rep3.bam", "03_mapping/DHX9_UV_rep1.bam", "03_mapping/DHX9_UV_rep2.bam", "03_mapping/DHX9_UV_rep3.bam"], "log": ["09_multiQC/multiQC.log"], "output": ["09_multiQC/multiqc_report.html"], "rule": "multiQC", "jobid": 8, "resources": {}, "threads": 1, "params": {"indirs": " 01_fastq/adaptor_trimmed/fastqc 01_fastq/adaptor_trimmed 03_mapping", "outdir": "09_multiQC"}, "local": false}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake 09_multiQC/multiqc_report.html 09_multiQC/multiQC.log --snakefile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.ropcw3io 01_fastq/adaptor_trimmed/fastqc/20190410hela_endoDHX9_FLASH_R1_fastqc.html 01_fastq/adaptor_trimmed/fastqc/20190410hela_endoDHX9_FLASH_R2_fastqc.html 01_fastq/adaptor_trimmed/20190410hela_endoDHX9_FLASH_R1.fastq.gz 01_fastq/adaptor_trimmed/20190410hela_endoDHX9_FLASH_R2.fastq.gz 03_mapping/DHX9_WT_rep1.bam 03_mapping/DHX9_WT_rep2.bam 03_mapping/DHX9_WT_rep3.bam 03_mapping/DHX9_UV_rep1.bam 03_mapping/DHX9_UV_rep2.bam 03_mapping/DHX9_UV_rep3.bam --latency-wait 100 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
 --configfile /home/suny/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/example_config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules multiQC  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.ropcw3io/8.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.ropcw3io/8.jobfailed"; exit 1)

