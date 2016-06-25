#!/usr/bin/env Rscript

# PART I - ARGUMENTS

# R CMD BATCH --no-save --no-restore '--args INQURE_REGION="chr6:30132134-32138339" GROUPS=c(2,2,2,2,1,1) FIN_NAME="data/data.txt" FOUT_NAME="TMP"' bin/crest_edger.R test.out
# ./bin/crest_edger.R INQURE_REGION=\'chr6:30132134-32138339\' GROUPS="c(2,2,2,2,2,1,1)" FIN_NAME=\"data/data.txt\" FOUT_NAME=\"TMP\"

#option_list <- list(
#  make_option(c("-n", "--count_lines"), action="store_true", default=FALSE,
#    help="Count the line numbers [default]"),
#  make_option(c("-f", "--factor"), type="integer", default=3,
#    help="Multiply output by this number [default %default]")
#)
#
#parser <- OptionParser(usage="%prog [options] file", option_list=option_list)
#
#args <- parse_args(parser, positional_arguments = 2)
#opt <- args$options
#file <- args$args
#
#if(opt$count_lines) {
#  print(paste(length(readLines(file)) * opt$factor))
#}

# PART 0 - check if packages are installed
list.of.packages <- c("edgeR", "GenomicRanges")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)){
	source("http://bioconductor.org/biocLite.R")
	biocLite(new.packages, lib.loc = "~/R/local_library", lib="~/R/local_library")
}

list.of.packages <- c("locfit", "stringr", "optparse")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)){
	install.packages(new.packages, lib.loc = "~/R/local_library", lib="~/R/local_library")
}

# import pakcage
suppressMessages(library(edgeR))
suppressMessages(library(GenomicRanges))
suppressMessages(library(locfit))
suppressMessages(library(stringr))
suppressMessages(library(optparse))

args <- commandArgs(trailingOnly = TRUE)
print(args)
if(length(args) < 4){
    stop("too few arguments.")
}else{
    for(i in 1:length(args)){
		print(args[[i]])
		eval(parse(text=args[[i]]))
    }
}


print(INQURE_REGION)
print(GROUPS)
print(FIN_NAME)
print(FOUT_NAME)

if(!exists("MIN_COUNT")) MIN_COUNT=10
if(!exists("CUTOFF_PVALUE")) CUTOFF_PVALUE=0.05
if(!exists("BIN_SIZE")) BIN_SIZE=50
if(!exists("INQURE_REGION")) stop("argument INQURE_REGION missing")
if(!exists("FIN_NAME")) stop("argument FIN_NAME missing")
if(!exists("FOUT_NAME")) stop("argument FOUT_NAME missing")
if(!exists("GROUPS")) stop("argument GROUPS missing")
if(!file.exists(FIN_NAME)) stop("file FIN_NAME not exists")

data <- read.table(FIN_NAME, head=TRUE, row.names=1)
if(length(str_extract_all(INQURE_REGION, perl("chr[0-9a-zA-Z_]*:[0-9]+-[0-9]+"))[[1]])==0) stop("argument INQURE_REGION not in chr1:10000-20000 format")
if(ncol(data) != length(GROUPS)) stop("argument GROUPS does not match with input data")

# interprate input parameter
inqure_cord <- as.data.frame(do.call(rbind, strsplit(INQURE_REGION, ":|-")))
inqure_chrom <- as.character(inqure_cord[1,1])
inqure_start <- as.numeric(as.character(inqure_cord[1,2]))
inqure_end <- as.numeric(as.character(inqure_cord[1,3]))

#label_neg = label_pos = NULL
#if(length(i <- grep("POS", rownames(data)))) label_pos = i
#if(length(i <- grep("NEG", rownames(data)))) label_neg = i
#label_use <- setdiff(1:nrow(data), c(label_pos, label_neg))
#X = list(counts=data, pos=label_pos, neg=label_neg, use=label_use)
#
## Need a CPM (count per million) greater than 5 in at least 1/3 of the samples
#if(length(i <- which(rowSums(cpm(X$counts) > 2) >= (ncol(X$counts)/3)))) X$use <- intersect(X$use, i)
#
##barplot(colSums(X$counts[X$use,]), main="Counts per sample", cex.names=0.5, cex.axis=0.8)
##barplot(rowSums(X$counts[X$use,]), las=2, main="Counts per sgRNA", axisnames=FALSE, cex.axis=0.8)
##plotMDS(X$counts[X$use,], main="MDS Plot: drug treatment colours")
##dev.off()
#
## postive control or negative control
## y <- DGEList(X$counts[unique(c(X$pos, X$neg, X$use)),], group=group)
## design <- model.matrix(~group)
## xglm <- estimateDisp(y, design)
## fit <- glmFit(xglm, design)
## lrt <- glmLRT(fit, coef=2)
## sgRNA <- lrt$table
## sgRNA$score <- sign(sgRNA$logFC) * (log(sgRNA$PValue))
#
## plot(edge$logCPM, edge$logFC, cex=0.45, pch=1, col="grey",xlab="log(Count Per Million)", ylab="log(Fold Change)")			#
## ind.sel <- which(edge$PValue<=CUTOFF_PVALUE & edge$logFC >= 0)
## points(edge$logCPM[ind.sel], edge$logFC[ind.sel], cex=0.45, pch=4, col="red")
## points(edge$logCPM[1:length(X$pos)], edge$logFC[1:length(X$pos)], cex=0.45, pch=1, col="green")
## points(edge$logCPM[(length(X$pos) + 1):(length(X$pos) + length(X$neg))], edge$logFC[(length(X$pos) + 1):(length(X$pos) + length(X$neg))], cex=0.45, pch=4, col="black")
## legend( x="topright", legend=c("Significant","Positive", "Negative"), col=c("red","green", "black"), lwd=1, lty=c(NA,NA), pch=c(4,1,4) )
## dev.off()
#
## sort sgRNA pairs
#y <- DGEList(X$counts[X$use,], group=GROUPS)
#design <- model.matrix(~GROUPS)
#xglm <- estimateDisp(y, design)
#fit <- glmFit(xglm, design)
#lrt <- glmLRT(fit, coef=2)
#sgRNA <- lrt$table
#sgRNA$score <- sign(sgRNA$logFC) * (log(sgRNA$PValue))
#sgRNA <- sgRNA[order(sgRNA$score),]
#sgRNA$rank <- 1:nrow(sgRNA)
#sgRNA <- sgRNA[order(rownames(sgRNA)),]
#
#
## generate sgRNA.gr
#cooridnates <- as.data.frame(do.call(rbind, strsplit(as.character(rownames(sgRNA)), ":|-")))
#sgRNA <- cbind(cooridnates, sgRNA)
#sgRNA.gr <- GRanges(seqnames = sgRNA[,1], ranges = IRanges(as.numeric(as.character(sgRNA[,2])), as.numeric(as.character(sgRNA[,3]))), score=sgRNA$score)
#
## split given inqure region into bin
#tmp = seq(inqure_start, inqure_end, by=BIN_SIZE)
#bins.gr <- GRanges(seqnames = inqure_chrom, ranges = IRanges(tmp, end = tmp+BIN_SIZE))
#bins.gr$name <- paste(paste(inqure_chrom, tmp, sep=":"), tmp+BIN_SIZE, sep="-")
#
## overlap
#ov <- as.data.frame(findOverlaps(bins.gr, sgRNA.gr, type="within"))
#res <- data.frame(bin=bins.gr$name[ov$queryHits], score=sgRNA.gr$score[ov$subjectHits], subjectHits=ov$subjectHits)
#res <- res[order(res$subjectHits),]
#
#res$rank = 1:nrow(res)
#index <- do.call(rbind, lapply(split(res[,c(3,4)], res$subjectHits), function(x) x[1,]))
#res$chosen = 0
#res$chosen[index$rank] = 1
#
#res.high <- data.frame(sgrna=1:nrow(res), symbol=res$bin, pool="list", p.high=res$score, prob=1, chosen=res$chosen)
#
#write.table(res.high, file = FOUT_NAME, append = FALSE, quote = FALSE, sep = "\t",
#            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
#            col.names = TRUE, qmethod = c("escape", "double"),
#            fileEncoding = "")
#
