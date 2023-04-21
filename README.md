# Designed-Breeding-Simulation-too
**Designed Breeding Simulation (DBS) tool** is developed for the selection of potential parents and breeding strategies, estimation of breeding population size, and achieving the pyramiding of superior alleles.


## Installation

**DBS tools**  can be installed with the following R code:
```
git clone https://github.com/XiaoboMM/Designed-Breeding-Simulation-tool.git
```
## Example

There are three example datasets attached in DBS tool, , users can export and view the details by following R code:
```
#The genotype of the material at the instresting QTL and genes. The character format of genotype data to numeric codes of 0, 1 and 2 representing missing, superior alleles and inferior alleles, respectively.
> pop_file <- read.csv("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/genotype_pop.csv", header = T, check.names = F)
> pop_file[(1:5), c(1:5)]
> pop_file[(1:5), c(1:5)]
  Trait     QTL       Jimai22 Jinan13 X04zhong36
1   TGW   QTgw.1B.1       2       2          1
2   FSN   QFsn.1B.1       2       2          2
3   TGW   QTgw.1B.2       1       1          1
4   DST   QDst.1D.1       1       2          2
5   FSN   QFsn.2A.1       2       1          1
```


```
## The detailed information of QTL and genes
> qtl_file <- read.table("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/QTL.txt", sep = "\t", check.names = F, header = T)
> head(qtl_file)
  Trait       QTL   Chr       Pos
1   FSN QFsn.1B.1 Chr1B 137.00311
2   FSN QFsn.2A.1 Chr2A 113.29670
3   FSN QFsn.2B.1 Chr2B  99.79318
4   FSN QFsn.4A.1 Chr4A  76.79357
5   FSN QFsn.4A.2 Chr4A 144.37692
6   FSN QFsn.6A.1 Chr6A  84.11215

As the example dataset, the first four columns are names, related-traits, chromosomes, genetic positions of QTL and genes, respectively.
