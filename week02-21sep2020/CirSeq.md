# Circular sequencing (CirSeq) of viral RNA


## What it does

Circularized genomic RNA fragments are used to generate tandem repeats.
They then serve as substrates for next-generation sequencing.
This provides sequence redundancy for each genomic fragment derived from a single individual within the virus population.
Observed differences in each redundant set must originate from enzymatic or sequencing errors and can be filtered statistically.
This overcomes the limitations of next-generation sequencing error. 

Source: [1, Main].

## Technology

Viral population is multiplied in vivo. 
RNA extracted from the viral population is purified, fragmented, size-selected, circularized, reverse-transcribed,
and cloned. 
These libraries are sequences on Illumina (MiSeq).
Bowtie 2 and custom analysis software are used for sequence mapping,
identifying and aligning repeats.
A majority-vote consensus is established between redundant reads
and 
error probabilities are estimated.

Source: [1, Methods].

## Application

Determination of virus mutation rates is difficult and often unreliable because accuracy depends on observing rare events, but the accuracy improvement of CirSeq compared to conventional next-generation sequencing allows to capture a near-complete distribution of mutant frequencies within RNA virus populations. Also, CirSeq reduces the technical transversion (purine-pyrimidine) mutation bias. These nucleotide-specific differences in mutation rate likely reflect the molecular mechanism of viral polymerase fidelity, which can help understanding the directionality of evolution.

Source: [1, Main].

## Statistics

The statistical significance of mutations detected was determined by a one-sided binomial test in R
using the average estimated error probability at each genome position as the null probability of success.
The accuracy of frequencies was estimated using the standard error of a binomial distribution. 
A regression model based on classical population genetics was used to estimate fitness (relative growth rates of alleles).

Source: [1, Methods summary], [1, Eqn (1)].

## References

[1] 
Ashley Acevedo, Leonid Brodsky & Raul Andino.
Mutational and fitness landscapes of an RNA virus revealed through population sequencing. 
[Nature 505, pp. 686-690 (2014)](https://www.nature.com/articles/nature12861).

## Group members

[numpde](https://github.com/numpde) (RA)
/
[johaab](https://github.com/johaab) (JH)
/
[balayev1](https://github.com/balayev1) (AB)
/
[eroellSTA426](https://github.com/eroellSTA426) (ER)
/
[schmiddieth](https://github.com/schmiddieth) (DS)
/
[luknaegeli](https://github.com/luknaegeli) (LN)

Honorary member: [julvog](https://github.com/julvog) (JV)
