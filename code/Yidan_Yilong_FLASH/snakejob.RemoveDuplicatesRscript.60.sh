#!/bin/sh
# properties = {"log": ["ProcessedData/01aRemoveDuplicatesSTARRscript/Log/removedup.log"], "params": {"last_cs": "RawData/02aSplittingRscript/CSobject.Rdata", "input_dir": "RawData/03aMappingSTARRscript", "output_dir": "ProcessedData/01aRemoveDuplicatesSTARRscript", "rscript": "/data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/cage_pipeline/rscripts/removeduplicate.R"}, "type": "single", "local": false, "input": ["RawData/03aMappingSTARRscript/DHX9_WT_rep1.bam", "RawData/03aMappingSTARRscript/DHX9_WT_rep2.bam", "RawData/03aMappingSTARRscript/DHX9_WT_rep3.bam", "RawData/03aMappingSTARRscript/DHX9_UV_rep1.bam", "RawData/03aMappingSTARRscript/DHX9_UV_rep2.bam", "RawData/03aMappingSTARRscript/DHX9_UV_rep3.bam"], "resources": {}, "jobid": 60, "wildcards": {}, "threads": 20, "output": ["ProcessedData/01aRemoveDuplicatesSTARRscript/CSobject.Rdata", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep2.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep1.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep2.filtered.bam", "ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep3.filtered.bam"], "cluster": {"memory": "6G"}, "rule": "RemoveDuplicatesRscript"}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv && \
/package/anaconda3/envs/snakemake-5.1.2/bin/python \
-m snakemake ProcessedData/01aRemoveDuplicatesSTARRscript/CSobject.Rdata ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep1.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep2.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_WT_rep3.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep1.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep2.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/DHX9_UV_rep3.filtered.bam ProcessedData/01aRemoveDuplicatesSTARRscript/Log/removedup.log --snakefile /data/processing3/akhtargroup/sunyd/Snakemake/snakemake-TTseq/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.q1ui2i25 RawData/03aMappingSTARRscript/DHX9_WT_rep1.bam RawData/03aMappingSTARRscript/DHX9_WT_rep2.bam RawData/03aMappingSTARRscript/DHX9_WT_rep3.bam RawData/03aMappingSTARRscript/DHX9_UV_rep1.bam RawData/03aMappingSTARRscript/DHX9_UV_rep2.bam RawData/03aMappingSTARRscript/DHX9_UV_rep3.bam --latency-wait 300 \
 --attempt 1 \
--force-use-threads --wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/config.yaml  --nocolor \
--notemp --no-hooks --nolock --timestamp --mode 2  --force-use-threads  --allowed-rules RemoveDuplicatesRscript  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.q1ui2i25/60.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuv/.snakemake/tmp.q1ui2i25/60.jobfailed"; exit 1)
