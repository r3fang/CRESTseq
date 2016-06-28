##Requirements
- [samtools 1.2+](http://www.htslib.org/doc/samtools.html)
- [Python 2.7+](https://www.python.org/download/releases/2.7/)
- [R package edgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html)
- [R package GenomicRanges](https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html)

##Introduction

**crest** is an in-house Bioinformatics pipeline for CREST-seq analysis.

```
$ crest

Program: crest (CREST-seq analysis pipeline Ren Lab)
Version: v06.26.2016
Contact: Rongxin Fang <r3fang@ucsd.edu>
Ren Lab: http://bioinformatics-renlab.ucsd.edu/rentrac/

usage: crest [-h] [-i INPUT] [-r chr6:30132134-32138339] [-o PREFIX] [-m 5] [-s 50] [-c 3] [-p 0.05] [-l 1000]

Example:
crest -i data/data.txt -r chr6:30132134-32138339 -o demo

Options:
	-h, --help                  show this help message and exit.
	-i  INPUT                   input crest-standard matrix.
	-r  INQUIRE_REGION          region that CREST-seq performed against.
	-o  PREFIX                  prefix of outout file.
	-m  MIN_CPM                 sgRNA pairs with CPM (count per million) smaller than
	                            MIN_CPM will be filtered before analysis [5].
	-s  BIN_SIZE                screened region INQUIRE_REGION will be partitioned into
	                            a set of BIN_SIZE-bp bins [50].
	-c  MIN_COV                 a bin is considered significant at least MIN_COV pairs span it [2].
	-p  FDRCUTOFF               FDR cutoff for a significant bin [0.05].
	-l  MIN_WIDTH               a peak will be extended to MIN_WIDTH if shorter [1000].

Note: To use crest, please be sure that the input matrix is in the required format.
```

##FAQ

1. **What is crest required input format?**  
 
 |   | T1  | T2 | T3 | T4 | T5 | C1 | C2 |
 |:------------------:|:-------------:|:-----:|:------:|:-------:|
 | POS_1 | 257 | 3070 |	2663 | 83 | 3645 |	39 |	41  |
 | POS_2 | 149 | 2168 |	1773 | 70 | 2530 |	30 |	24  |
 | POS_3 | 396 | 5262 |	3869 | 169 |	6068 |	57  |	63 |
 | POS_4 | 332 | 3207 |	2606 | 115 |	4062 |	41  |	37 |
 | POS_5 | 829 | 8635 |	8256 | 298 |	11884 |	114 |	108 |
 | POS_6 | 560 | 7432 |	6409 | 280 |	9757 |	106	| 81 |

