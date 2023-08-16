---
title: "DESeq analysis of data from run2218"
output:
  html_document:
    df_print: paged
toc: yes
---



# 1. Sample sheet

The experimental design of the run:

| name | batch | condition | group |
|:---:|:---:|:---:|:---:|
| s1 | collA | totRNA_mock | All |
| s2 | collA | totRNA_mock | All |
| s3 | collB | totRNA_mock | All |
| s4 | collA | totRNA_arsenite | treatment1 |
| s5 | collB | totRNA_arsenite | treatment1 |
| s6 | collB | totRNA_arsenite | treatment1 |
| s7 | collB | totRNA_HS | treatment2 |
| s8 | collB | totRNA_HS | treatment2 |
| s9 | collB | totRNA_HS | treatment2 |
| s10 | collA | totRNA_NaCl | treatment3 |
| s11 | collB | totRNA_NaCl | treatment3 |
| s12 | collB | totRNA_NaCl | treatment3 |
| s13 | collA | totRNA_UV | treatment4 |
| s14 | collA | totRNA_UV | treatment4 |
| s15 | collB | totRNA_UV | treatment4 |
| s16 | collA | sgRNA_arsenite | treatment1 |
| s17 | collB | sgRNA_arsenite | treatment1 |
| s18 | collB | sgRNA_arsenite | treatment1 |
| s19 | collB | sgRNA_HS | treatment2 |
| s20 | collB | sgRNA_HS | treatment2 |
| s21 | collB | sgRNA_HS | treatment2 |
| s22 | collA | sgRNA_NaCl | treatment3 |
| s23 | collB | sgRNA_NaCl | treatment3 |
| s24 | collB | sgRNA_NaCl | treatment3 |
| s25 | collA | sgRNA_UV | treatment4 |
| s26 | collA | sgRNA_UV | treatment4 |
| s27 | collB | sgRNA_UV | treatment4 |



# 2. Load libraries and default parameters
```{r, load-libraries}
libr <- c("tidyverse", "DESeq2", "gtools", "ggplot2", "grid", "gridExtra", "ashr", "pheatmap")
invisible(lapply(libr, library, character.only = TRUE))
```

# 3. Load and clean the necessary data 

### 3.a) Load the data
```{r, load_data}
#setwd("code_clean")
dfolder <- "../output/"
fcounts_gene <- "1a_mRNAseq_alignment_1SampleSheet/featureCounts/counts.tsv"

df.counts_gene <- read.delim(paste0(dfolder, fcounts_gene), header = TRUE, 
                             sep='\t', na.strings="NA", row.names = 1) 
df.counts_gene  %>% head()
```

There are `r dim(df.counts_gene)[1]` genes and `r dim(df.counts_gene)[2]` samples in the gene count data frame.  


### 3.b) Load the metadata
```{r, label=check_counts, echo=FALSE}
fmeta_all <- "../data_int/sampleSheets/all_batch_corrected_sampleSheet.tsv"
df.meta_all <- read.delim(fmeta_all, header = TRUE, sep='\t', na.strings="NA", row.names = 1)
df.meta_all  %>% head()
```

### 3.c) Rearrange, clean and factor the data

There are `r dim(df.counts_gene)[1]` genes in total.  

```{r, label=cleanup}
# cleanup the metadata 
df.meta_all$condition <- gsub('arsenite', 'ars', df.meta_all$condition) 
#####################

# cleanup the data
# reorder the columns alphanumerically
df.counts_gene <- df.counts_gene[gtools::mixedorder(colnames(df.counts_gene))]

# remove the all the '_PAR_Y' rows because are empty
rows_PAR_Y <- row.names(df.counts_gene[grepl(pattern="_PAR_Y", row.names(df.counts_gene) ),])
df.counts_gene <- df.counts_gene[!row.names(df.counts_gene) %in% rows_PAR_Y,]

# remove the version number
row.names(df.counts_gene) <- gsub("\\..*","", row.names(df.counts_gene))
# are the metadata rows and data columns in the same order?
all( df.meta_all$name == colnames(df.counts_gene))

df.counts_gene  %>% head()
df.meta_all  %>% head()
```
  
  
After eliminating the PAR_Y genes, now there are still `r dim(df.counts_gene)[1]` genes left.  

```{r, factoring}
# populate the columns 'condition', 'batch' and 'group' with factors
df.meta_all[c("batch", "condition", "group")] <- lapply(df.meta_all[c("batch", "condition", "group")], factor)

#rearrange sample order:
l.sample_order <- c('totRNA_mock', 'totRNA_ars', 'totRNA_HS', 'totRNA_NaCl', 'totRNA_UV', 
                    'sgRNA_ars', 'sgRNA_HS', 'sgRNA_NaCl', 'sgRNA_UV')
df.meta_all$condition <- factor(df.meta_all$condition, levels = l.sample_order)

df.meta_all  %>% head()
```


# 4) Prepare to run DESeq2

```{r, design}
out_dir <- "../output/2a_mRNAseq_DESeq_manual"

# create design
design <- ~condition + batch

# make unfiltered dds obj
dds <- DESeq2::DESeqDataSetFromMatrix(countData = df.counts_gene, colData = df.meta_all, design = design)

# for plotting 
# either transform the dds object or load the rld object 
rld <- rlog(dds, blind = TRUE)
```


# 4) PCA plots batch

```{r, PCA_loop_singles}

# want to plot all samples together and then separate by input type

# for samples with input from whole samples (totRNA)
v.cond_totRNA <- rld$condition[grepl(pattern = "totRNA_*", rld$condition), drop = TRUE]
rld.sub_totRNA <- rld[,rld$condition %in% v.cond_totRNA]
rld.sub_totRNA$condition <- droplevels(rld.sub_totRNA$condition)


# for samples with input from stress granules (sgRNA)
v.cond_sgRNA <- rld$condition[grepl(pattern = "sgRNA_*", rld$condition), drop=TRUE]
rld.sub_sgRNA <- rld[,rld$condition %in% v.cond_sgRNA]
rld.sub_sgRNA$condition <- droplevels(rld.sub_sgRNA$condition)

l.namePCA2 <- list("rld", "rld.sub_sgRNA", "rld.sub_totRNA")
######################

l.colors <- c("dark grey",
              "royalblue","#00b159", "#ffc425", "red",
              "#00aedb", "darkseagreen1", "yellow", "pink")
# set the levels as names for colors for the rld dataset, such that the other 2 being subsets, will inherit the same colors
palette.color <-setNames(l.colors, levels(rld$condition))
###########################

f.PCAreplot2 = function (rld) {
  l.intgroups2 <- "condition"
  rld$condition <- factor(rld$condition)

  # add a manual color palette (9-colors)
  # attach specific colors for each level of the condition column, so that for the subsets can retain the color scheme

  sub.palette.color  <- palette.color[names(palette.color) %in% levels(rld$condition)]

  # run functions
  rld.PCA <- DESeq2::plotPCA(rld, intgroup=l.intgroups2, returnData=TRUE)
  percentVar <- round(100 * attr(rld.PCA, "percentVar"), 1)   # rounded values for each axis of PC variance

  # plot the PCA
  ggplot(rld.PCA, aes(PC1, PC2, color=condition)) +
    geom_point(aes(color=condition, fill=condition), size=4, shape=24)+
    theme_classic(base_size = 12) +
    xlab(paste0("PC1: ",percentVar[1])) +
    ylab(paste0("PC2: ",percentVar[2])) +

    # for same axes:
    coord_fixed(xlim=c(-40, 40),ylim=c(-20,30)) +

    # color for the edge
    scale_colour_manual(values = c(rep("black", nlevels(rld.PCA$condition))) ) +

    # filling color and for the legend
    scale_fill_manual(values=sub.palette.color,
                      guide=guide_legend(override.aes = list(color=sub.palette.color, shape=22, size=4) ) )
}
######################################

par(oma = c(2,2,2,1),    # margins for whole plot
    mar = c(3.1, 2.1, 2.1, 1.1)  # margins for individual plots
    )

layout(matrix(c(1, 2, 3), 1, 3))

# run function and save plots to a list, use lines 'p<-' and 'l.plots'
# to just show the plots (comment previous lines; uncomment 'print' line)
for (i in 1:length(l.namePCA2) ) {
  print(f.PCAreplot2(get(l.namePCA2[[i]])) +
              ggtitle(paste0("PCA plot for ", l.namePCA2[[i]]) )  +
              theme(plot.title = element_text(hjust = 0.5)))

}
```

No prefiltering done.  


# 5) Run DESeq 

Split the totRNA samples from the sgRNA samples and analyze the separately.  
  

```{r, run-DESeq2}
#des_all <- DESeq(dds) 
#saveRDS(des_all, file=paste0(out_dir,'/', 'des_all.Rdata'))
des_all <- readRDS(file=paste0(out_dir,'/', 'des_all.Rdata'))
```


# 6) get results

Run the results() function and extract the needed lists

```{r, results_out, warning=FALSE, message=FALSE, tidy=TRUE}

# results for totRNA
resultsNames(des_all)


# no lfcThresholding here
# how many 'condition_' we have
RNA_contrasts <- list(c("condition", levels(dds$condition)[1], levels(dds$condition)[2]), 
                      c("condition", levels(dds$condition)[1], levels(dds$condition)[3]),
                      c("condition", levels(dds$condition)[1], levels(dds$condition)[4]),
                      c("condition", levels(dds$condition)[1], levels(dds$condition)[5]),

                      c("condition", levels(dds$condition)[9], levels(dds$condition)[6]),
                      c("condition", levels(dds$condition)[9], levels(dds$condition)[7]),
                      c("condition", levels(dds$condition)[9], levels(dds$condition)[8]),
                     
                      c("condition", levels(dds$condition)[8], levels(dds$condition)[6]), 
                      c("condition", levels(dds$condition)[8], levels(dds$condition)[7]),
                     
                      c("condition", levels(dds$condition)[7], levels(dds$condition)[6])
                      )


alfa_param <- 0.05
padj_param <- 0.05
lfc_thresh <- 0
prefix <- 'resRNA_'
######################################

for (k in RNA_contrasts){
  nameContrast <- paste0(prefix, k[2], "_vs_", k[3]) 
  
  
  # get the results for each contrast
  assign(nameContrast,
         results(des_all, contrast=k, alpha=alfa_param, pAdjustMethod = "BH",  lfcThreshold = lfc_thresh)  )

  # get shrunk estimate for each contrast
  assign(paste0(nameContrast,"_shrink"),
         lfcShrink(des_all, contrast=k, type='ashr')  )

  # subset the shrunk results at padj < 0.05
  assign(paste0(nameContrast,"_shrink_padj",padj_param),
         subset(get(paste0(nameContrast,"_shrink") ), padj <= padj_param) )

  # arrange the subset by padj
  assign(paste0(nameContrast,"_shrink_padj",padj_param, "_sort"),
         get(paste0(nameContrast,"_shrink_padj0.05"))[order(get(paste0(nameContrast,"_shrink_padj0.05"))$padj),] )

  
  # write out files
  writeLines('gene_ID',
              con = paste0(out_dir, '/', nameContrast,"_shrink_padj0.05_sort.tsv"), sep='\t')
  # append to that same file the rest of the dataframe
  write.table(get(paste0(nameContrast,"_shrink_padj0.05_sort")),
               file = paste0(out_dir, '/', nameContrast,"_shrink_padj0.05_sort.tsv"),
               quote=FALSE, sep='\t', col.names = NA, append = TRUE)
  
  writeLines('gene_ID',
              con = paste0(out_dir, '/', nameContrast,"_shrink.tsv"), sep='\t')
  write.table(get(paste0(nameContrast,"_shrink")),
               file = paste0(out_dir, '/', nameContrast,"_shrink.tsv"),
               quote=FALSE, sep='\t', col.names = NA, append = TRUE)
}
```

# 7) Explore the results 


### 7) a. MA plots on Shrunk data sets
```{r, MAplots_shrink_totRNA, fig.height=7, fig.width=10}
v.condTotRNA <- RNA_contrasts[grepl(pattern = "totRNA_*", RNA_contrasts)]
########################################

par(oma = c(2,2,2,1),   
    mar = c(3.1, 2.1, 2.1, 1.1) 
    )

layout(matrix(c(1, 2, 3, 4), 2, 2))
yl <- c(-6, 6)
options(scipen=0) # to get scientific notation

for (i in 1:length(v.condTotRNA) ) {
  DESeq2::plotMA(get(paste0(prefix, v.condTotRNA[[i]][2], "_vs_", v.condTotRNA[[i]][3], "_shrink")), 
                 alpha=0.05, 
                 main=paste0(v.condTotRNA[[i]][2], "_vs_", v.condTotRNA[[i]][3]), 
                 ylim=yl, 
                 xlab='', ylab='', 
                 colSig='red',
                 cex.axis=1, 
                 cex.main=1)
  abline(h=c(-1,1),col="dodgerblue",lwd=2)
  }

title(main = paste0("MA plots for DE analysis_shrink, alpha<0.05"),
      xlab = "Mean expression",
      ylab = "Log fold change",
      outer = TRUE, line = 1,
      cex.lab=1.5, cex.main=1.5)
```

```{r, MAplots_shrink_sgRNA, fig.height=9, fig.width=10}
v.condSgRNA <- RNA_contrasts[grepl(pattern = "sgRNA_*", RNA_contrasts)]
########################################

par(oma = c(2,2,2,1),    # margins for whole plot
    mar = c(3.1, 2.1, 2.1, 1.1)  # margins for individual plots
    )

layout(matrix(c(1, 2, 3, 
                4, 5, 6), 3, 2))

options(scipen=0) # to get scientific notation

for (i in 1:length(v.condSgRNA) ) {
  DESeq2::plotMA(get(paste0(prefix, v.condSgRNA[[i]][2], "_vs_", v.condSgRNA[[i]][3], "_shrink")), 
                 alpha=0.05, 
                 main=paste0(v.condSgRNA[[i]][2], "_vs_", v.condSgRNA[[i]][3]), 
                 ylim=yl, 
                 xlab='', ylab='', 
                 colSig='red',
                 cex.axis=1, 
                 cex.main=1)
  abline(h=c(-1,1),col="dodgerblue",lwd=2)
  }

title(main = paste0("MA plots for DE analysis_shrink, alpha<0.05"),
      xlab = "Mean expression",
      ylab = "Log fold change",
      outer = TRUE, line = 1,
      cex.lab=1.5, cex.main=1.5)
```


### 7) b. volcano plots

```{r, volcano_plots_totRNA, fig.height=7, fig.width=10}
par(oma = c(2,2,2,1),  
    mar = c(4.1, 4.1, 2.1, 1.1) 
    )
layout(matrix(c(1, 2, 3, 4), 2, 2))

options(scipen=0)

for (i in 1:length(v.condTotRNA) ) {
  # Make a basic volcano plot
  with(get(paste0(prefix, v.condTotRNA[[i]][2], "_vs_", v.condTotRNA[[i]][3], "_shrink")), 
       plot(log2FoldChange, -log10(pvalue), pch=20, 
            main=paste0(v.condTotRNA[[i]][2], "_vs_", v.condTotRNA[[i]][3]), 
            xlim=c(-4,4), ylim=c(0,250)))
  
  # Add colored points: blue if padj<0.01, red if log2FC>1 and padj<0.05)
  with(subset(get(paste0(prefix, v.condTotRNA[[i]][2], "_vs_", v.condTotRNA[[i]][3], "_shrink")), 
              padj<.05 ),
              points(log2FoldChange, -log10(pvalue), pch=20, col="blue"))
  with(subset(get(paste0(prefix, v.condTotRNA[[i]][2], "_vs_", v.condTotRNA[[i]][3], "_shrink")), 
              padj<.05 & abs(log2FoldChange)>2), 
              points(log2FoldChange, -log10(pvalue), pch=20, col="red"))
  }
```


```{r, volcano_plots_sgRNA, fig.height=9, fig.width=10}

par(oma = c(2,2,2,1),    
    mar = c(4.1, 4.1, 2.1, 1.1)  
    )
layout(matrix(c(1, 2, 3, 
                4, 5, 6), 3, 2))

options(scipen=0)
for (i in 1:length(v.condSgRNA) ) {
  # Make a basic volcano plot
  with(get(paste0(prefix, v.condSgRNA[[i]][2], "_vs_", v.condSgRNA[[i]][3], "_shrink")), 
       plot(log2FoldChange, -log10(pvalue), pch=20, 
            main=paste0(v.condSgRNA[[i]][2], "_vs_", v.condSgRNA[[i]][3]), 
            xlim=c(-4,4), ylim=c(0,300)))
  
  # Add colored points: blue if padj<0.01, red if log2FC>1 and padj<0.05)
  with(subset(get(paste0(prefix, v.condSgRNA[[i]][2], "_vs_", v.condSgRNA[[i]][3], "_shrink")), 
              padj<.05 ),
              points(log2FoldChange, -log10(pvalue), pch=20, col="blue"))
  with(subset(get(paste0(prefix, v.condSgRNA[[i]][2], "_vs_", v.condSgRNA[[i]][3], "_shrink")), 
              padj<.05 & abs(log2FoldChange)>2), 
              points(log2FoldChange, -log10(pvalue), pch=20, col="red"))
  }
```


