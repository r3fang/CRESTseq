##Get Started

```bash
$ git clone https://github.com/r3fang/crest.git
$ cd crest
$ bash install.sh
$ # check if input file is valid
$ crest_input_check -i data/data.txt 
$ crest -i data/data.txt -t T1,T2,T3,T4,T5 -c C1,C2 -r chr6:30132134-32138339 -o demo 
```

##Introduction

**crest** is an in-house Bioinformatics pipeline for CREST-seq analysis.

```
$ crest

Program: crest (CREST-seq analysis pipeline Ren Lab)
Version: v07.02.2016
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

##FAQ

1. **What is valid input format for crest?**  
 In short, you can check if your input file is in the format required by crest by crest_input_check:
 
 ```bash
 $ crest_input_check -i data/data.txt
 Succeed! data/data.txt is in valid crest-standard matrix format!
 ```
 
 In detail, crest input requires:
 + the first row should be the name of samples' ID. 
 + from the second row, the first column should be the deletion coordinates of sgRNA pairs. 
 + from the second row, the rest of columns should be raw read counts (no normalization). 
 + deletion coordinates must be valid (chr:start-end) and start must smaller than end.
 
 Below is a valid crest input format example:
 
 |  | T1 | T2 | T3 | T4 | T5 | C1 | C2 |  
 |:------------------:|:-------------:|:-----:|:------:|:-------:|:-------:|:-------:|:-------:|
 | chr6:30235217-30237927	|5	 |121	|1	 |6	   |108	   |198	   |82
 | ...	|...	 |...	|...	 |...	   |...	   |...	   |...
 | chr6:30235672-30242444	|164 |833	|356 |10   |1294   |1471   |490

2. **what is 'error: RRA fais to generate p value for bins.'**  
 crest requires at least 3GB memory, the error is due to not enough memory.
 
 
 
 
 
 
 
 
