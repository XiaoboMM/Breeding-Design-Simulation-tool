source("D:\\winter_article\\new_research_direction\\population_size\\F1DH.R")
source("D:\\winter_article\\new_research_direction\\population_size\\F1RIL.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC1DH.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC1RIL.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC2DH.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC2RIL.R")
source("D:\\winter_article\\new_research_direction\\population_size\\F2.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC1F2.R")
source("D:\\winter_article\\new_research_direction\\population_size\\F2enrichment.R")
source("D:\\winter_article\\new_research_direction\\population_size\\F2enrichmentDH.R")
source("D:\\winter_article\\new_research_direction\\population_size\\F2enrichmentRIL.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC1F2enrichment.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC1F2enrichmentDH.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC1F2enrichmentRIL.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC2F2enrichment.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC2F2enrichmentDH.R")
source("D:\\winter_article\\new_research_direction\\population_size\\BC2F2enrichmentRIL.R")

startDesign <- function(P1, selected_pop, qtl_file, pop_file, out_file){
  library(dplyr)
  library(readr)
  library(tidyr)
  library(data.table)
  library(openxlsx)
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
    df1[2] = ceiling(df1[2])
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
  

