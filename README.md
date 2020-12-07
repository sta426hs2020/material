# Statistical Analysis of High-Throughput Genomic and Transcriptomic Data
Fall/Herbst-semester 2020

## Lectures
Mondays 9.00-9.45 (remote), 10.00-10.45 (remote)

## Exercises
Monday 11.00-11.45 (remote)

## Lecturersa

[Dr. Hubert Rehrauer](http://www.fgcz.ch/the-center/people/rehrauer.html), Group Leader of Genome Informatics at [FGCZ](http://www.fgcz.ch/)  

[Prof. Dr. Mark Robinson](https://robinsonlabuzh.github.io/), Associate Professor of Statistical Genomics, [IMLS](http://www.imls.uzh.ch/index.html), UZH  

## Teaching Assistant

[Ahmadreza Yousefkhani](https://ir.linkedin.com/in/ahmadreza-yousefkhani-3b2a99a8), M.Sc. student in Computational Biology and Bioinformatics  


## Schedule

| Date  | Lecturer | Topic | Exercise | JC1 | JC2 | Tutorial | 
| --- | --- | --- | --- | --- | --- | --- |
| 14.09.2020  | Mark + Hubert  | admin; mol. bio. basics | R markdown; git(hub) | <img width=100/> | <img width=100/> | <img width=100/> |
| 21.09.2020  | Mark | interactive technology/statistics session  | group exercise: technology pull request | | | Exploratory data analysis and visualization with ggplot2 and dplyr | 
| 28.09.2020  | Hubert | NGS intro; exploratory data analysis | EDA in R | | | PCA - concept and pitfalls | 
| 05.10.2020  | Hubert | mapping  | Rsubread | | | Linear regression, diagnostic plots and residual analysis | 
| 12.10.2020  | Mark | limma + friends | linear model simulation + design matrices | | | Linear regression, tests and confidence regions, F-value analysis | 
| 19.10.2020  | Hubert | RNA-seq quantification    | RSEM  | | | R-squared and model selection in linear models, Mallow Cp statistic, AIC, BIC criterion  | 
| 26.10.2020  | Mark | edgeR+friends 1 | basic edgeR/voom | [DUBStepR: correlation-based feature selection for clustering single-cell RNA sequencing data](https://www.biorxiv.org/content/10.1101/2020.10.07.330563v1.full.pdf) (TK, SS, TE) | [From expression footprints to causal pathways: contextualizing large signaling networks with CARNIVAL](https://www.nature.com/articles/s41540-019-0118-z) (DC, LM) | Bayesian linear regression | 
| 02.11.2020  | Mark | edgeR+friends 2  | GLM/DEXSeq |[Redefining CpG islands using hidden Markov models](https://academic.oup.com/biostatistics/article/11/3/499/256898) (Zhiwei Dou, Huixin Jin, Peiying Cai)| [Causal Inference in Genetic Trio Studies](https://arxiv.org/abs/2002.09644) (ZS, GW, LN) | Empirical Bayes | 
| 09.11.2020  | Kathi | hands-on session #1: RNA-seq  | FASTQC/Salmon/etc. | [Statistical significance for genomewide studies](https://www.pnas.org/content/100/16/9440) (RA, HH, JR) | [Identifying signaling genes in spatial single cell expression data](https://www.biorxiv.org/content/10.1101/2020.07.27.221465v2) (YM, KD, GJ) | MLE, Fisher information, assymptotic efficiency | 
| 16.11.2020  | Hubert | single-cell 1: preprocessing, dim. reduction, clustering | | [Testing hypotheses about the microbiome using the linear decomposition model](https://www.biorxiv.org/content/10.1101/229831v3.full.pdf+html) (FS,BO,SA) | [Generalizing RNA velocity to transient cell states through dynamical modeling](https://www.nature.com/articles/s41587-020-0591-3?proof=t) (DP, EH) | Likelihood ratio statistics, profile likelihood | 
| 23.11.2020  | Stephany | hands-on session #2: cytometry  | cytof null comparison | [Genome-wide detection of intervals of genetic heterogeneity associated with complex traits](https://academic.oup.com/bioinformatics/article/31/12/i240/216593) (Richard Affolter, Philip Hartout, Martin Emons) | [Empirical Bayes Analysis of a Microarray Experiment](https://www.tandfonline.com/doi/abs/10.1198/016214501753382129) (Jennifer Probst, Eljas Röllin, Lisa Herzog) | Validation of models, sequential cross validation | 
| 30.11.2020  | Mark | single-cell 2: clustering, marker gene DE  | marker gene DE | [A Bayesian mixture model for the analysis of allelic expression in single cells](https://doi.org/10.1038/s41467-019-13099-0) (Sneha-Sundar,SmaragdaDimitrakopoulou,marinapanteli) | [scMET: Bayesian modelling of DNA methylation heterogeneity at single-cell resolution](https://www.biorxiv.org/content/10.1101/2020.07.10.196816v2) (MW, RM, DW) | Managing your projects with workflowr | 
| 07.12.2020  | Pierre-Luc | hands-on session #3: single-cell RNA-seq (cell type definition, differential state)  | full scRNA-seq pipeline | [ScreenBEAM: a novel meta-analysis algorithm for functional genomics screens via Bayesian hierarchical   modeling](https://academic.oup.com/bioinformatics/article/32/2/260/1743949) (Leonor Schubert, Jonathan   Haab, Flavio Rump) | [Detection of differentially abundant cell subpopulations discriminates biological states in scRNA-seq data](https://www.biorxiv.org/content/10.1101/711929v3) (TE, RB, AB) | Shiny apps, developing panels | 
| 14.12.2020  | Mark | loose ends: HMM, EM, robustness   | segmentation, peak finding | [Single-cell mRNA quantification and differential analysis with Census](https://www.nature.com/articles/nmeth.4150) (HML, SCD, SW) | [A test metric for assessing single-cell RNA-seq batch correction](https://www.nature.com/articles/s41592-018-0254-1) (Dimitri Schmid, Lola Kouroma, Jonas Bucher); [AUC-RF: A New Strategy for Genomic Profiling with Random Forest](https://www.karger.com/Article/Abstract/330778) (Jonas Meirer, Dominique Paul) | Advancing shiny apps, introduction to open source data | 



## Course material

Assuming you have git installed locally, you can check out the entire set of course materials with the following command (from command line):
```
git clone https://github.com/sta426hs2020/material.git
```  
Alternatively, for a ZIP file of the repository, you can click on the (green) 'Clone or download' (top right) and then click 'Download ZIP'.

