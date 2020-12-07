# STA426 Exercise 13

## Cross-sample scRNAseq differential state analysis

<p align="right">Pierre-Luc Germain, 02.12.2020</p>

### Getting started

The aim of this exercise is to practice and push further what has been done during the hands-on session. We will be working with the same dataset, namely a single-cell RNA-seq of mouse cortex injected with LPS or with a vehicle treatment (see [Crowell et al.](https://www.nature.com/articles/s41467-020-19894-4)). You can download the data in [SingleCellExperiment (SCE)](https://bioconductor.org/packages/release/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html) format [here](http://imlspenticton.uzh.ch/teaching/STA426/), or with:

```
# download the single-cell counts:
download.file("http://imlspenticton.uzh.ch/teaching/STA426/week13.SCE.rds", destination="week13.SCE.rds")
# the pseubo-bulk aggregation:
download.file("http://imlspenticton.uzh.ch/teaching/STA426/week13.PB.rds", destination="week13.PB.rds")
```

The code used during the hands-on session is available [here](workflow.Rmd). An example of a different workflow on this very dataset, from pre-processing to clustering and differential state analysis, is available [here](http://htmlpreview.github.io/?https://github.com/HelenaLC/BC2_2019-workshop_multi-scRNA-seq/blob/master/LPS/docs/index.html).

### Per-celltype DS analysis and comparison

The goal of the exercise is to try to disentangle celltype-specific responses to the treatment. For the first part, follow the following steps:

1. Repeat the differential state analysis as we did in the course using [muscat](https://bioconductor.org/packages/release/bioc/html/muscat.html) (or take your saved output from the course).
2. Compare the differentially-expressed genes across the different cell types, for instance using [UpSet plots](https://cran.r-project.org/web/packages/UpSetR/index.html).
3. Choose one cell type, find some genes that are significant in only that cell type, and plot their pseudo-bulk profile across the dataset (e.g. with `muscat::pbHeatmap`, or flattened heatmaps using `SEtools`). Are they truly cell-type specific?

### Global DS analysis

Instead of running the differential expression analysis separately for each cell type, like `muscat` does, we can also run it for all cell types together. This allows us to use the framework of generalized linear models (GLMs)<sup>[1](#f1)</sup> to capture effects in terms of global treatment (i.e. group) effect, and interaction terms capturing the additional effect of the treatment in specific cell types. The second part of the exercise is to try such an approach. More specifically:

1. Build a pseudo-bulk `SummarizedExperiment` or counts matrix that contains all cell types (e.g. `muscat::pbFlatten`).
2. Build a `model.matrix` that captures i) the different cell types (`cluster_id`), ii) the different treatments (`group_id`), and iii) their interaction.
3. Run differential expression analysis (e.g. using `edgeR`), and extract the genes with a significant global treatment effect, and the genes with a significant cell type effect (interaction term) for the cell type you selected in #3.
4. Compare these sets of genes with the ones found in the first part (#1-3). Do you find more, or less genes? To what extent do the sets overlap between the two analyses? How do you interpret the differences?

***

<a name="f1">[1]</a>: 
For a refresher on the use of GLMs, see for instance the examples in the `edgeR::edgeRUsersGuide()` (chapter 3), or the `limma::limmaUsersGuide()` (chapter 9).
