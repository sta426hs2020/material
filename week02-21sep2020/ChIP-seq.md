# Chromatin Immunoprecipitation coupled with ultra-high-throughput-sequencing (ChIP-seq)

## What it does
ChIP-seq is a technique used to assess where transcription factors and other proteins bind to DNA. It does so by using immunoprecipitation, which is a method that employs antibodies to precipitate proteins bound to DNA and shear the rest of DNA. The precipitated DNA can then be sequenced.

## Link
### Technology: 
Cells are treated with formaldehyde to __crosslink proteins to DNA__ (e.g. Transcription Factors). The DNA is then digested to smaller fragments (<1kb) by using external forces (e.g. sonication, high temperatures) or by means of enzymatic digestion (e.g. micrococcal nuclease). [Note: Enzymatic digestions usually leads to more consistent results as high temperatures or sonication are harsh conditions for chromatin.] 
DNA fragments that are bound to specific proteins are then targeted by one or more specific antibodies, and collected by means of __immunoprecipitation__.  DNA that was not bound to an antibody-bound protein is discarded. The crosslinks between DNA and proteins are then reversed, and __DNA is subsequently amplified for selected DNA sizes__. Sequenced reads are then mapped to a reference genome and normalized.

### Application:
ChIP-seq is a powerful method for __epigenomic research__ and __quantifying protein-DNA interactions__. As such, it allows characterising regulatory areas of genes, and which regulators act on these areas (i.e. promotors, repressors, ...). ChIP-seq can therefore be used to study how these regulators contribute to cell identity and development.

### Statistics:
As described by Ma and Wong, the goal of ChIP-seq analysis is to "[...] gain an adequate number of mappapble reads aggregated at the target regions" (https://doi.org/10.1016/B978-0-12-385075-1.00003-2, 2011). As such, reads from ChIP-seq experiments are first __mapped__ to a reference genome. Depending on the method and settings used for read mapping, one can make the alignment more or less restrictive by allowing mismatches of certain sizes (e.g. indels). 

 Reads are then __normalized for comparative analysis__, usually under the assumption that the difference in mapped reads is much smaller than the total read number. Depending on the experiment itself, more complicated methods for normalization need to be applied.

__Peak calling__ is the most crucial part of ChIP-seq analysis. Peak here describes a local maximum of read counts from the same strand of DNA in a protein-bound DNA fragment. A peak around a protein-DNA interaction area will be given by a __bi-horned normal distribution__ on 5'- and 3'-ends. This is because of the underlying biology of sequencing, where we sequence strands from both 5'- and 3'-ends. The shape of these curves thus already gives an insight into how successful the experiment was. 

A common algorithm for peak calling is __MACS2__. The distance between those two curves in the alignment is then defined as d, which represents the estimated fragment length. These are shifted by d/2 towards 3', and a window of size 2d is slid across the genome to find candidate peaks. The __Poisson distribution__ and the __negative binomial distribution__ are commonly used for modelling the expected number of reads (lambda) in that window. A region is then considered to have sign. enrichment if p<10e-5. MACS also applies the __Benjamini-Hochberg correction__ to reduce false discoveries of peaks.


### Github Usernames of the Participants
 * sevwal
 * bubibyte
 * Sann5
 * mjemons

### Resources:
- David S. Johnson et al., “Genome-Wide Mapping of in Vivo Protein-DNA Interactions,” Science 316, no. 5830 (June 8, 2007): 1497–1502, doi:10.1126/science.1141319.
- Ma, Hung Wong, Chapter Three - The Analysis of ChIP-Seq Data. Methods in Enzymology, vol. 497, pp. 51-73 (2011). https://doi.org/10.1016/B978-0-12-385075-1.00003-2
- Mistry, Khetani. Introduction to ChIP-Seq using high-performance computing. https://hbctraining.github.io/Intro-to-ChIPseq/lessons/05_peak_calling_macs.html
- Nakato, Toyonori, Methods for ChIP-seq analysis: A practical workflow and advanced applications. Methods, 1046-2023 (2020). https://doi.org/10.1016/j.ymeth.2020.03.005
