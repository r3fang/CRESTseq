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
 
 |  | T1 | T2 | T3 | T4 | T5 | C1 | C2 |  
 |:------------------:|:-------------:|:-----:|:------:|:-------:|:-------:|:-------:|:-------:|
 | chr6:30235161-30256924	|16	 |244	|96	 |12   |249	   |286	   |19
 | chr6:30235217-30237927	|5	 |121	|1	 |6	   |108	   |198	   |82
 | ...	|...	 |...	|...	 |...	   |...	   |...	   |...
 | chr6:30235672-30242444	|164 |833	|356 |10   |1294   |1471   |490
 | chr6:30236585-30243109	|6	 |94	|0	 |11   |130	   |306	   |309

