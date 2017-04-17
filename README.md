##Get Started

```sh
$ git clone https://github.com/r3fang/crest.git
$ cd crest
$ bash install.sh
# if install fails, you might have to install manually as shown in FAQ
$ # check if input file is in valid format
$ crest_input_check -i data/data.txt 
$ crest -i data/data.txt -t T1,T2,T3,T4,T5 -c C1,C2 -r chr6:30132134-32138339 -o demo 
```

##Introduction

**crest** is a simple-version in-house pipeline for CREST-seq analysis.

```
$ crest

Program: crest (CREST-seq analysis pipeline Ren Lab)
Version: v04.17.2017
Contact: Rongxin Fang <r3fang@ucsd.edu>
URL: https://github.com/r3fang/crest

usage: crest [-h] [-i INPUT] [-t T1,T2,T3] [-c C1,C2,C3] [-r chr6:30132134-32138339] [-o PREFIX] [-m 5] [-s 50] [-n 3] [-p 0.05] [-l 1000]

Example:
crest -i data/data.txt -t T1,T2,T3,T4,T5 -c C1,C2 -r chr6:30132134-32138339 -o demo

Options:
  -- Required:
      -i    STR     input crest-standard matrix.
      -t    STR     treatment sample IDs, seperated by comma without space.
      -c    STR     control sample IDs, seperated by comma without space.
      -r    STR     region that CREST-seq performed against (e.g. chr1:1-100).
      -o    STR     prefix of outout files.
  -- Optional:
      -m    INT     sgRNA pairs with CPM (count per million) smaller than [3]
                    will be filtered before peak calling.
      -s    INT     screened region -r will be splitted into bins of [50] bp.
      -n    INT     a bin is considered significant with at least [3] pairs span it.
      -p    FLOAT   score cutoff for a significant bin [0.1].
      -l    INT     a peak will be extended to [1000] bp if shorter .

Note: To use crest, please be sure that the input matrix is in the required format.
      Check if your input is crest-required format: 'crest_input_check -i data/data.txt'

```

