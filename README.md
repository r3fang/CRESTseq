# Installation

**crest** is a simple-version in-house pipeline for CREST-seq analysis which requires R,  R packages (locfit, stringr, edgeR, GenomicRanges), samtools (1.2), python.

| Dependency | URL |
| ------ | ------ |
| R | https://www.r-project.org/ |
| locfit (R)| https://www.bioconductor.org/packages/release/bioc/html/flowFit.html |
| stringr (R)| https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html |
| edgeR (R)| https://bioconductor.org/packages/release/bioc/html/edgeR.html |
| GenomicRanges (R) | https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html  |
| samtools (1.2) | https://sourceforge.net/projects/samtools/files/samtools/1.2/  |
| python (2.7) | https://www.python.org/download/releases/2.7/ |

The **installation** contains the following steps:
* [clone] - clone the repertoire
```sh
git clone https://github.com/r3fang/crest.git
```
* [compile] - compile RRA and other programs
```sh
if [ -f ./bin/RRA ]; then
	rm ./bin/RRA
fi
chmod +x ./bin/*
cd rra; make; cd ..;
```

* [path] - add the ./bin folder to .bash_profile
```
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "export PATH=\$PATH:$DIR/bin" >> ~/.bash_profile
bash ~/.bash_profile
```

* [samtools] - install samtools if not installed
```sh
command -v samtools >/dev/null 2>&1 || {
	wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2;
	tar -vxjf samtools-1.2.tar.bz2;
	cd samtools-1.2;
	make;
	cd ..;
	cp samtools-1.2/samtools ./bin/;
	rm samtools-1.2.tar.bz2
}
```

* [R packages] - install R packages
```sh
# install locfit
wget https://cran.r-project.org/src/contrib/locfit_1.5-9.1.tar.gz
R CMD INSTALL --clean -l $R_LIBS locfit_1.5-9.1.tar.gz
# install stringr and its dependencies
wget https://cran.r-project.org/src/contrib/magrittr_1.5.tar.gz
R CMD INSTALL --clean -l $R_LIBS magrittr_1.5.tar.gz
wget https://cran.r-project.org/src/contrib/stringr_1.0.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS stringr_1.0.0.tar.gz
# install edgeR
wget https://bioconductor.org/packages/release/bioc/src/contrib/edgeR_3.14.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS edgeR_3.14.0.tar.gz

# install GenomicRanges and its depednencies (or use bioconductor)
wget https://bioconductor.org/packages/release/bioc/src/contrib/zlibbioc_1.18.0.tar.gz
wget http://bioconductor.org/packages/3.1/bioc/src/contrib/BiocGenerics_0.14.0.tar.gz
wget http://bioconductor.org/packages/3.1/bioc/src/contrib/XVector_0.8.0.tar.gz
wget http://bioconductor.org/packages/3.1/bioc/src/contrib/GenomicRanges_1.20.8.tar.gz
R CMD INSTALL --clean -l $R_LIBS BiocGenerics_0.14.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS zlibbioc_1.18.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS XVector_0.8.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS GenomicRanges_1.20.8.tar.gz
```

# Get started

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

# Cite
Diao Y\*, Fang R.\*, Li B.\*, Meng Z., Yu J., Qiu Y., Lin K., Huang H., Liu T., Marina R.J., Jung I., Shen Y., Guan K., Ren B. A tiling-deletion-based genetic screen for cis-regulatory element identification in mammalian cells. Nature Methods (2017) doi:10.1038/nmeth.4264 (\* contributed equally)

# Licence
MIT
