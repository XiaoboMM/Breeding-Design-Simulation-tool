# Designed-Breeding-Simulation-tool
**Designed Breeding Simulation (DBS) tool** is developed for the selection of potential parents and breeding strategies, estimation of breeding population size, and achieving the pyramiding of superior alleles.


## Installation

**DBS tool**  can be installed with the following R code:
```
git clone https://github.com/XiaoboMM/Designed-Breeding-Simulation-tool.git
```
## Example

There are four example datasets attached in DBS tool, , users can export and view the details by following R code:
```
#The genotype of the materials at the instresting QTL and genes.
> pop_file <- read.csv("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/genotype_pop.csv", header = T, check.names = F)
> pop_file[(1:5), c(1:5)]
  Trait     QTL       Jimai22 Jinan13 04zhong36
1   DST   QDst.1B.1       1       2         2
2   TGW   QTgw.1B.1       2       2         1
3   GPC   QGpc.1B.1       2       2         1
4   FSN   QFsn.1B.1       2       2         2
5   TGW   QTgw.1B.2       1       1         1

The character format of genotype data to numeric codes of 0, 1 and 2 representing missing, superior alleles and inferior alleles, respectively.
```


```
## The detailed information of QTL and genes
> qtl_file <- read.table("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/QTL.txt", sep = "\t", check.names = F, header = T)
> head(qtl_file)
  Trait       QTL Chr    Pos
1   FSN QFsn.1B.1  1B 667.97
2   FSN QFsn.2A.1  2A 675.94
3   FSN QFsn.2B.1  2B 439.23
4   FSN QFsn.4A.1  4A 616.31
5   FSN QFsn.4A.2  4A 726.22
6   FSN QFsn.6A.1  6A 520.88

As the example dataset, the first four columns are names, related-traits, chromosomes, physical positions (Mb) of QTL and genes, respectively.
```






```
#The general linkage map
> map <- read.csv("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/general_linkage_map.csv", header = T)
> head(map)
  Chromosome Physical_position Genetic_position
1         1A                 0             0.00
2         1A                 1             0.94
3         1A                 2             1.02
4         1A                 3             1.72
5         1A                 4             2.30
6         1A                 5             2.88

As the example dataset, the three columns are chromosomes, physical positions (Mb) and genetic position (cM), respectively.
```
