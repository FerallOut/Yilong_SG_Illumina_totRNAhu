#!/bin/sh
# properties = {"threads": 10, "type": "single", "jobid": 23, "local": false, "cluster": {"memory": "6G"}, "output": ["ProcessedData/03bPeakCallingSTARTSSRscript/CSobject.Rdata", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed", "ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed"], "log": ["ProcessedData/03bPeakCallingSTARTSSRscript/tss.log"], "wildcards": {}, "input": ["ProcessedData/01aRemoveDuplicatesSTARRscript/CSobject.Rdata"], "rule": "PeaksCallingTSSRscript", "resources": {}, "params": {"sampleinfo": "/data/processing3/akhtargroup/sunyd/Projects/FastqZhou2019FlashHumanDHXuv/sampleInfo.tsv", "output_dir": "ProcessedData/03bPeakCallingSTARTSSRscript/", "window_size": 50, "prefix": "tss_foldch_2.5", "rscript": "/data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/cage_pipeline/rscripts/tssdetection.R", "fold_change": "2.5"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake ProcessedData/03bPeakCallingSTARTSSRscript/CSobject.Rdata ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_WT.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_DHX9_UV.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss_foldch_2.5_merged.bed ProcessedData/03bPeakCallingSTARTSSRscript/tss.log --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.kpi_0_uh ProcessedData/01aRemoveDuplicatesSTARRscript/CSobject.Rdata --latency-wait 300 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules PeaksCallingTSSRscript  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.kpi_0_uh/23.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.kpi_0_uh/23.jobfailed"; exit 1)

