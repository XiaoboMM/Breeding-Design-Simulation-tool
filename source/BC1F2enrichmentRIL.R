
BC1F2enrichmentRIL <- function(P1, selected_pop, qtl_file, pop_file){
  df <- pop_file%>%
    select(-Trait)%>%
    select(QTL, P1, everything())%>%
    gather(mat, allele, c(3:(dim(pop_file)[2]-1)))
  names(df)[c(1,2, 3)] = c("QTL", "P1","Name")
  dat <- selected_pop%>%
    filter(Name != P1)%>%
    select(Name)
  
  data <- merge(dat, df, by = "Name", all.x = T)%>%
    filter(P1 != 0)%>%
    filter(allele != 0)
  
  
  ####find different loci
  for (line in c(1:dim(data)[1])){
    if (data[line, 3] != data[line, 4]){
      data[line, 5] = 1
    } else {
      data[line, 5] = 0
    }
  }
  data1 <- filter(data, V5 == 1)%>%
    select(-V5)
  
  ###添加QTL的位置信息
  qtl <- qtl_file%>%
    select(QTL, Chromosome, Genetic_position)
  
  mydata <- merge(data1, qtl, by = "QTL", all.x = T)%>%
    arrange(Chromosome, Genetic_position)
  
  ######计算NminPBC1F2enrichmentRIL，计算PBC1F2enrichmentRIL最小群体大小
  data_pop_size <- data.frame(stringsAsFactors = F)
  for (trait in (1: dim(dat)[1])){
    ##############计算PBC1F2enrichmentRIL最小群体大小
    p_inf <- filter(mydata, Name == dat[trait, 1]) 
    ###按照不同染色体进行分组
    mm <- c()
    nn = 1
    f = 1
    chr <- unique(p_inf$Chromosome)
    
    ################################################################
    for (chrom in 1:length(chr)){
      #print(chrom)
      p_inf_chr <- filter(p_inf, Chromosome == chr[chrom])####提取每条染色体上的位点信息
      if (dim(p_inf_chr)[1] > 1){##染色体上存在两个或两个以上的位点
        for (i in 1:(dim(p_inf_chr)[1]-1)){
          Dis <- as.numeric(p_inf_chr[i+1, 6]-p_inf_chr[i, 6])##两标记间遗传距离
          r = 1/2*(1-exp(-Dis/50))###重组率
          R=2*r/(1+2*r)
          if (p_inf_chr[i, 3] == 1){ ##########################P1BC1F2enrichmentRIL#################
            if (p_inf_chr[i, 3] != p_inf_chr[i+1, 3]){
              ##P1=AAbb, P2 = aaBB, P1BC1F2enrichmentRIL代不同基因型频率如下
              ##(1/8*r+1/8*r^2*(1-r)+1/2*(1/4+1/4*r*(1-r)^2)+1/2*(1/4+1/4*r*(1-r)^2)+(1/2*(1-R))*(1/4*r^2*(1-r))+(1/2*R)*(1/4*(1-r)^3))/p4
              p4 = 1/8*r+1/8*r^2*(1-r)+1/4+1/4*r*(1-r)^2+1/4+1/4*r*(1-r)^2+1/4*r^2*(1-r)+1/4*(1-r)^3
              p = (1/8*r+1/8*r^2*(1-r)+1/2*(1/4+1/4*r*(1-r)^2)+1/2*(1/4+1/4*r*(1-r)^2)+(1/2*(1-R))*(1/4*r^2*(1-r))+(1/2*R)*(1/4*(1-r)^3))/p4##携带两个目的基因均为纯合概率
            } else {
              ##P1=AABB, P2 = aabb, P1BC1F2enrichmentRIL代不同基因型频率如下
              ##p(AABB) = (1/2-1/4*r+1/8*(1-r)^3+1/2*(1/4+1/4*r*(1-r)^2)+1/2*(1/4+1/4*r*(1-r)^2)+(1/2*(1-R))*(1/4*(1-r)^3)+ (1/2*R)*(1/4*r^2*(1-r)))/p3
              p3 = 1/2-1/4*r+1/8*(1-r)^3+1/4+1/4*r*(1-r)^2+1/4+1/4*r*(1-r)^2+1/4*(1-r)^3+1/4*r^2*(1-r)
              p = (1/2-1/4*r+1/8*(1-r)^3+1/2*(1/4+1/4*r*(1-r)^2)+1/2*(1/4+1/4*r*(1-r)^2)+(1/2*(1-R))*(1/4*(1-r)^3)+ (1/2*R)*(1/4*r^2*(1-r)))/p3##携带两个目的基因均为纯合的概率
            }
          } else {  ###################P2BC1F2enrichmentRIL##################
            if (p_inf_chr[i, 3] != p_inf_chr[i+1, 3]){
              ##P1=AAbb, P2 = aaBB, P2BC1F2enrichmentRIL代不同基因型频率如下
              ##p(AABB) = (1/8*r+1/8*r^2*(1-r)+1/2*(1/4*r*(1-r)^2) +1/2*(1/4*r*(1-r)^2)+ (1/2*(1-R))*(1/4*r^2*(1-r))+ (1/2*R)*(1/4*(1-r)^3))/p6
              p6 = 1/8*r+1/8*r^2*(1-r)+1/4*r*(1-r)^2+1/4*r*(1-r)^2+1/4*r^2*(1-r)+1/4*(1-r)^3
              p = (1/8*r+1/8*r^2*(1-r)+1/2*(1/4*r*(1-r)^2) +1/2*(1/4*r*(1-r)^2)+ (1/2*(1-R))*(1/4*r^2*(1-r))+ (1/2*R)*(1/4*(1-r)^3))/p6##携带两个目的基因均为纯合概率
            } else {
              ##P1=AABB, P2 = aabb, P2BC1F2enrichmentRIL代不同基因型频率如下
              ##p(AABB) = (1/8*(1-r)^3+1/2*1/4*r*(1-r)^2+1/2*1/4*r*(1-r)^2+(1/2*(1-R))*(1/4*(1-r)^3)+ (1/2*R)*(1/4*r^2*(1-r)))/p5
              p5 = 1/8*(1-r)^3+1/4*r*(1-r)^2+1/4*r*(1-r)^2+1/4*(1-r)^3+1/4*r^2*(1-r)
              p = (1/8*(1-r)^3+1/2*1/4*r*(1-r)^2+1/2*1/4*r*(1-r)^2+(1/2*(1-R))*(1/4*(1-r)^3)+ (1/2*R)*(1/4*r^2*(1-r)))/p5##携带两个目的基因均为纯合的概率
            }
          }
          mm[nn] = p
          nn = nn + 1
          f = f*p
        }
      } else {##染色体上存在1个位点
        if (p_inf_chr[1, 3] == 1){ ##########################P1BC1F2enrichmentRIL#################
          p = 6/7
        } else { ##################P2BC1F2enrichmentRIL#################
          p = 2/3
        }
        mm[nn] = p
        nn = nn + 1
        f = f*p
      }
    }
    #print(mm)
    ###α = 0.01
    NminF2 <- log(0.01)/log(1-f)
    mat_name = dat[trait, 1]
    data_pop_size[trait, 1] = mat_name
    data_pop_size[trait, 2] = NminF2
  }
  names(data_pop_size) = c("Name", "NminBC1F2enrichmentRIL")
  write.csv(data_pop_size, paste("NminBC1F2enrichmentRIL", "_population_size.csv", sep = ""), quote = F, row.names = F)
  
}
  