#!/usr/bin/env bash
set -e

R_LIBS=~/R/CREST_R_LIBS/

echo step 1. compiling all programs
if [ -f ./bin/RRA ]; then
	rm ./bin/RRA
fi
chmod +x ./bin/*
cd rra; make; cd ..

echo step 2. add `pwd`/bin to the PATH permanently
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "export PATH=\$PATH:$DIR/bin" >> ~/.bash_profile
echo "export R_LIBS=$R_LIBS" >> ~/.bash_profile
bash ~/.bash_profile

if [ ! -d $R_LIBS ]; then
	mkdir $R_LIBS
fi

echo step 3. install required R packages \(locfit, stringr, edgeR, GenomicRanges\)
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

# install GenomicRanges and its depednencies
wget https://bioconductor.org/packages/release/bioc/src/contrib/zlibbioc_1.18.0.tar.gz
wget http://bioconductor.org/packages/3.1/bioc/src/contrib/BiocGenerics_0.14.0.tar.gz
wget http://bioconductor.org/packages/3.1/bioc/src/contrib/XVector_0.8.0.tar.gz
wget http://bioconductor.org/packages/3.1/bioc/src/contrib/GenomicRanges_1.20.8.tar.gz

R CMD INSTALL --clean -l $R_LIBS BiocGenerics_0.14.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS zlibbioc_1.18.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS XVector_0.8.0.tar.gz
R CMD INSTALL --clean -l $R_LIBS GenomicRanges_1.20.8.tar.gz

echo step 4. clean up
rm locfit_1.5-9.1.tar.gz 
rm magrittr_1.5.tar.gz
rm stringr_1.0.0.tar.gz 
rm edgeR_3.14.0.tar.gz 
rm BiocGenerics_0.14.0.tar.gz
rm zlibbioc_1.18.0.tar.gz
rm XVector_0.8.0.tar.gz
rm GenomicRanges_1.20.8.tar.gz

