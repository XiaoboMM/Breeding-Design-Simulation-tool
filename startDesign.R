source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/F1DH.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/F1RIL.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC1DH.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC1RIL.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC2DH.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC2RIL.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/F2.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC1F2.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/F2enrichment.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/F2enrichmentDH.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/F2enrichmentRIL.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC1F2enrichment.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC1F2enrichmentDH.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC1F2enrichmentRIL.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC2F2enrichment.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC2F2enrichmentDH.R", encoding = "utf-8")
source("https://raw.githubusercontent.com/XiaoboMM/Designed-Breeding-Simulation-tool/master/source/BC2F2enrichmentRIL.R", encoding = "utf-8")
library(dplyr)
library(readr)
library(tidyr)
library(data.table)

startDesign <- function(P1, selected_pop, qtl_file, pop_file){
  F1DH(P1, selected_pop, qtl_file, pop_file)
  F1RIL(P1, selected_pop, qtl_file, pop_file)
  BC1DH(P1, selected_pop, qtl_file, pop_file)
  BC1RIL(P1, selected_pop, qtl_file, pop_file)
  BC2DH(P1, selected_pop, qtl_file, pop_file)
  BC2RIL(P1, selected_pop, qtl_file, pop_file)
  F2(P1, selected_pop, qtl_file, pop_file)
  BC1F2(P1, selected_pop, qtl_file, pop_file)
  F2enrichment(P1, selected_pop, qtl_file, pop_file)
  F2enrichmentDH(P1, selected_pop, qtl_file, pop_file)
  F2enrichmentRIL(P1, selected_pop, qtl_file, pop_file)
  BC1F2enrichment(P1, selected_pop, qtl_file, pop_file)
  BC1F2enrichmentDH(P1, selected_pop, qtl_file, pop_file)
  BC1F2enrichmentRIL(P1, selected_pop, qtl_file, pop_file)
  BC2F2enrichment(P1, selected_pop, qtl_file, pop_file)
  BC2F2enrichmentDH(P1, selected_pop, qtl_file, pop_file)
  BC2F2enrichmentRIL(P1, selected_pop, qtl_file, pop_file)
  
  strategy <- c("F1DH", "F1RIL", "BC1DH", "BC1RIL", "BC2DH", "BC2RIL", "F2", "BC1F2", "F2enrichment",
                "F2enrichmentDH", "F2enrichmentRIL", "BC1F2enrichment", "BC1F2enrichmentDH",
                "BC1F2enrichmentRIL", "BC2F2enrichment", "BC2F2enrichmentDH", 
                "BC2F2enrichmentRIL")
  data <- data.frame(stringsAsFactors = F)
  for (i in strategy){
    df <- read.csv(paste("Nmin",i, "_population_size.csv", sep = ""), header = T)
    df1 <- select(df, Name, dim(df)[2])
    names(df1)[2] = i
    df2 <- data.frame(t(df1))
    colnames(df2) = df2[1,]
    df3 <- df2[-1,]
    df3$Strategy = row.names(df3)
    df4 <- select(df3, dim(df3)[2], everything())
    #names(df4)[1] = "Strategy"
    data <- rbind(data, df4)
    
  }
  write.csv(data, "Minimum_population_size.csv", row.names = F, quote = F)
  
}
  

