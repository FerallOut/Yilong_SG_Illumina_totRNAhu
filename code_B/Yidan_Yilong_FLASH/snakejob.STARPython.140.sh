#!/bin/sh
# properties = {"type": "single", "rule": "STARPython", "local": false, "input": ["RawData/02bSplittingPython/DHX9_UV_rep1_R1.fastq.gz", "RawData/02bSplittingPython/DHX9_UV_rep1_R2.fastq.gz"], "output": ["RawData/03bMappingSTARPython/DHX9_UV_rep1.bam", "RawData/03bMappingSTARPython/DHX9_UV_rep1.bam.bai"], "wildcards": {"base": "DHX9_UV_rep1"}, "params": {"star_options": "--outFilterMismatchNmax 2 --alignSJoverhangMin 1000 --alignIntronMax 1", "gtf": "--sjdbGTFfile /data/repository/organisms/GRCh38_ensembl/gencode/release_27/genes.gtf", "genome_fasta": "/data/repository/organisms/GRCh38_ensembl/genome_fasta/genome.fa", "index": "/data/repository/organisms/GRCh38_ensembl/STARIndex/", "sample_dir": "RawData/03bMappingSTARPython/DHX9_UV_rep1", "prefix": "RawData/03bMappingSTARPython/DHX9_UV_rep1/DHX9_UV_rep1."}, "log": [], "threads": 20, "resources": {}, "jobid": 140, "cluster": {"memory": "6G"}}
cd /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs && \
/data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/bin/python3.7 \
-m snakemake RawData/03bMappingSTARPython/DHX9_UV_rep1.bam --snakefile /home/suny/scripts/snakeRNAPipes/workflows/FLASH-seq/Snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l RawData/02bSplittingPython/DHX9_UV_rep1_R1.fastq.gz RawData/02bSplittingPython/DHX9_UV_rep1_R2.fastq.gz /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes/eeac4364 --latency-wait 300 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
--directory /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs --configfile /data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/FLASH-seq.config.yaml  --allowed-rules STARPython --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --conda-prefix /data/processing3/akhtargroup/sunyd/miniconda3/envs/snakeRNAPipes  && touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/140.jobfinished" || (touch "/data/processing3/akhtargroup/sunyd/Projects/Zhou2019FlashHumanDHXuvPairs/.snakemake/tmp.xdallo5l/140.jobfailed"; exit 1)

