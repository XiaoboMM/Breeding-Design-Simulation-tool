# Designed-Breeding-Simulation-tool
DBS tool: Designed Breeding Simulation tool
#
DBS tool is developed for the selection of potential parents and breeding strategies, estimation of breeding population size, and achieving the pyramiding of superior alleles.
DBS tool can help breeders to develop effective strategies for variety development.
#
There are three example datasets attached in DBS tool, users can export and view the details by following R code:  
selected_pop<- read.csv("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/genotype_pop.csv", header = T)  
qtl_file <- read.table("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/QTL.txt", header = T, sep = "\t")  
trait_type <- read.table("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/data/Trait_Type.txt", header = T, sep = "\t")
