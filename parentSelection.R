
parentSelection <- function(P1, genotype_pop, trait_type, percent_all, percent_T1, 
                            percent_T2 = 1, percent_T3 = 1, percent_T4 = 1, 
                            percent_T5 = 1, percent_T6 = 1){
  library(dplyr)
  library(readr)
  library(tidyr)
  library(data.table)
  library(stringr)
  library(ggplot2)
  library(openxlsx)
  ####Calculate the number of complementary QTLs for all other materials and material 'P1'
  dff <- genotype_pop%>%
    select(QTL, P1, everything())%>%
    select(-Trait)
  
  df <- gather(dff, mat, allele, c(3:dim(dff)[2]))
  names(df)[c(2,4)] <- c("P1", "P2")
  
  for (line in c(1:dim(df)[1])){
    if (df[line, 2] == 2 & df[line, 4] == 1){
      df[line, 5] = 1
    } else {
      df[line, 5] = 0
    }
    if (df[line, 2] == 1 & df[line, 4] == 2){
      df[line, 6] = 1
    } else {
      df[line, 6] = 0
    }
  }
  
  names(df)[5] <- "P1Inf_P2Sup"
  names(df)[6] <- "P1Sup_P2Inf"
  
  
  dat1 <- mutate(df, Dif_locus = P1Inf_P2Sup + P1Sup_P2Inf)%>%
    select(mat, P1Inf_P2Sup, P1Sup_P2Inf, Dif_locus)%>%
    group_by(mat)%>%
    summarise(P1Inf_P2Sup_Num = sum(P1Inf_P2Sup))
  
  dat2 <- mutate(df, Dif_locus = P1Inf_P2Sup + P1Sup_P2Inf)%>%
    select(mat, P1Inf_P2Sup, P1Sup_P2Inf, Dif_locus)%>%
    group_by(mat)%>%
    summarise(P1Sup_P2Inf_Num = sum(P1Sup_P2Inf))
  
  dat3 <- mutate(df, Dif_locus = P1Inf_P2Sup + P1Sup_P2Inf)%>%
    select(mat, P1Inf_P2Sup, P1Sup_P2Inf, Dif_locus)%>%
    group_by(mat)%>%
    summarise(Dif_locus_Num = sum(Dif_locus))
  
  
  #################
  dat <- merge(dat1, dat2, by = "mat", all = T)%>%
    merge(dat3, by = "mat", all = T)%>%
    arrange(P1Sup_P2Inf_Num)%>%
    arrange(Dif_locus_Num)%>%
    arrange(desc(P1Inf_P2Sup_Num))
  
  
  trait_type <- trait_type
  Num_trait <- dim(trait_type)[1]
  for (i in (1:Num_trait)){
    T1 = trait_type$Trait[i]
    ####Improve Trait1 and calculate the number of complementary P1 QTLs for all other materials and materials 'P1'
    dff_T <- genotype_pop%>%
      filter(Trait == T1)%>%
      select(QTL, P1, everything())%>%
      select(-Trait)
    df_T <- gather(dff_T, mat, allele, c(3:dim(dff_T)[2]))
    names(df_T)[c(2,4)] <- c("P1", "P2")
    
    
    for (line in c(1:dim(df_T)[1])){
      if (df_T[line, 2] == 2 & df_T[line, 4] == 1){
        df_T[line, 5] = 1
      } else {
        df_T[line, 5] = 0
      }
      if (df_T[line, 2] == 1 & df_T[line, 4] == 2){
        df_T[line, 6] = 1
      } else {
        df_T[line, 6] = 0
      }
    }
    names(df_T)[5] <- "P1Inf_P2Sup_T"
    names(df_T)[6] <- "P1Sup_P2Inf_T"
    dat_T1 <- mutate(df_T, Dif_locus_T = P1Inf_P2Sup_T + P1Sup_P2Inf_T)%>%
      select(mat, P1Inf_P2Sup_T, P1Sup_P2Inf_T, Dif_locus_T)%>%
      group_by(mat)%>%
      summarise(P1Inf_P2Sup_Num_T = sum(P1Inf_P2Sup_T))
    
    dat_T2 <- mutate(df_T, Dif_locus_T = P1Inf_P2Sup_T + P1Sup_P2Inf_T)%>%
      select(mat, P1Inf_P2Sup_T, P1Sup_P2Inf_T, Dif_locus_T)%>%
      group_by(mat)%>%
      summarise(P1Sup_P2Inf_Num_T = sum(P1Sup_P2Inf_T))
    
    dat_T3 <- mutate(df_T, Dif_locus_T = P1Inf_P2Sup_T + P1Sup_P2Inf_T)%>%
      select(mat, P1Inf_P2Sup_T, P1Sup_P2Inf_T, Dif_locus_T)%>%
      group_by(mat)%>%
      summarise(Dif_locus_Num_T = sum(Dif_locus_T))
    
    dat_T <- merge(dat_T1, dat_T2, by = "mat", all = T)%>%
      merge(dat_T3, by = "mat", all = T)%>%
      arrange(P1Sup_P2Inf_Num_T)%>%
      arrange(Dif_locus_Num_T)%>%
      arrange(desc(P1Inf_P2Sup_Num_T))
    names(dat_T)[2:4] <- c(paste("P1Inf_P2Sup_Num_", T1, sep = ""), 
                           paste("P1Sup_P2Inf_Num_", T1, sep = ""), 
                           paste("Dif_locus_Num_", T1, sep = ""))
    dat <- merge(dat, dat_T, by = "mat", all = T)
  }
  
  names(dat)[1] = "Name"
  write.csv(dat, "Summaize_Inf_Sup_ALL_sample.csv", quote = F, row.names = F)
  
  target_trait_type <- trait_type%>% ####target trait
    filter(Target == "Yes")
  
  ###################Set percentage
  percent = c(percent_T1, percent_T2, percent_T3, percent_T4, percent_T5, percent_T6)
  Num_target_trait <- dim(target_trait_type)[1]
  mm <- paste("P1Inf_P2Sup_Num_", target_trait_type$Trait, sep = "")
  dat_TT <- dat%>%
    select(Name, Dif_locus_Num, paste("P1Inf_P2Sup_Num_", target_trait_type$Trait, sep = ""))
  
  for (x in c(1:Num_target_trait)){
    dat_TT1 <- dat_TT%>%
      arrange(desc(dat_TT[,(2+x):3]))%>%
      mutate(num = seq(1,dim(dat_TT)[1],1))%>%
      slice_min(num, prop = percent[x])
    dat_TT <- dat_TT1
    
  }
  dat_TT1 <- dat_TT%>%
    arrange(desc(dat_TT[,(2+x):3]))%>%
    arrange(Dif_locus_Num)%>%
    mutate(num = seq(1,dim(dat_TT)[1],1))%>%
    slice_min(num, prop = percent_all)
  
  dat_P1 = as.data.frame(P1)
  names(dat_P1) = "Name"
  dat_sam <- as.data.frame(dat_TT1$Name)
  names(dat_sam) = "Name"
  dat_sample <- rbind(dat_P1, dat_sam)
  #write.csv(dat_sample, "selected_sample_Inf_Sup.csv",quote = F, row.names = F)
  
  
  selected_P <- select(dff, QTL, dat_sample$Name)%>%
    t()%>%
    as.data.frame(optional = T)
  names(selected_P) = selected_P[1,]
  selected_P <- selected_P[-1,]
  selected_P$Name = row.names(selected_P)
  selected_P_pop <- selected_P%>%
    select(Name, everything())
  
  write.table(selected_P_pop, "selected_pop.txt",quote = F, row.names = F, sep = "\t")
  
  
  ########Plot heatmap
  data <- selected_P_pop%>%
    gather(QTL, allele, 2:(dim(selected_P_pop)[2]))
  data$allele <- str_replace(data$allele, "2", "Inferior")
  data$allele <- str_replace(data$allele, "1", "Superior")
  data$allele <- str_replace(data$allele, "0", "Missing")
  data$Name <- factor(data$Name, levels = selected_P_pop$Name)
  data$allele <- factor(data$allele, levels = c("Superior","Inferior","Missing"))
  ggplot(data=data,aes(x=QTL,y=Name))+
    geom_tile(aes(fill=allele), color = "white")+ #geom_tile to draw a heat map using the value column as the color fillDraw a heat map using the value column as the color fill
    scale_fill_manual(values = c("#00BFC4", "#F8766D", "grey"))+
    theme_minimal()+
    theme(legend.title = element_blank(),
          axis.text.x=element_text(angle=45,vjust=1,hjust = 1,size=10,face = "italic"),
          axis.text.y=element_text(size=10))+
    labs(x = NULL, y = NULL)
  ggsave("headmap_allele.pdf", width = 9,height = 3,device = "pdf",dpi=300)
  

}
