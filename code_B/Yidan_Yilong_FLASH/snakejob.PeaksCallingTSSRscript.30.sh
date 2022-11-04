#!/bin/sh
# properties = {"wildcards": {}, "local": false, "params": {"fold_change": "2.5", "output_dir": "ProcessedData/03bPeakCallingSTARTSSRscript/", "window_size": 50, "rscript": "/data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/cage_pipeline/rscripts/tssdetection.R", "sampleinfo": "/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/sampleInfo.tsv", "prefix": "tss_foldch_2.5"}, "input": ["ProcessedData/01aRemoveDuplicatesSTARRscript/CSobject.Rdata"], "log": ["ProcessedData/03bPeakCallingSTARTSSRscript/tss.log"], "jobid": 30, "type": "single", "output": ["ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/CSobject.Rdata"], "cluster": {"memory": "6G"}, "rule": "PeaksCallingTSSRscript", "resources": {}, "threads": 10}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed ProcessedData/03bPeakCallingSTARTSSRscript/CSobject.Rdata ProcessedData/03bPeakCallingSTARTSSRscript/tss.log --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.7p4r7dks ProcessedData/01aRemoveDuplicatesSTARRscript/CSobject.Rdata --latency-wait 300 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules PeaksCallingTSSRscript  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.7p4r7dks/30.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.7p4r7dks/30.jobfailed"; exit 1)

