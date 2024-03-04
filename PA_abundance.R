source("Microbiome_data_processing.R")
abundance_analysis<-function(data,nsel_cols,region,prev_cutoff){
  m_data<-subset(data,select=nsel_cols)
  data<-subset(data,select = -which(colnames(data) %in% nsel_cols))
  
  #Relative abundance
  data<-(data/rowSums(data))*100
  
  library(ggpubr)
  library(ggforce)
  
  data=cbind(data,X=m_data[,region])
  f1<-ggboxplot(data,x="X",y="Pseudomonas aeruginosa",add = "jitter",xlab="",ylab="Relative abundance of Pseudomonas",color = "X",size=1)+
    facet_zoom(ylim = c(0, 1))
  
  #ggsave("abundace_plot_PA.png",width=19.16,height=10.03,units = "in",dpi=300)
  
  #=======Prevalence plots========
  
  a<-table(data$"Pseudomonas aeruginosa">prev_cutoff,data$X)
  b<-table(data$X)
  f2<-barplot(100*(a[2,]/b),horiz = TRUE,xlim = c(0,50))
  
  print(f1)
  print(f2)
  return(NULL)
  
}

#============EMBARC================
nsel_cols<-c("European_Region","FrequentExacerbator","Severity") #Choose from embarc metadata
region<-"European_Region"
abundance_analysis(emb,nsel_cols,region,1)

#============CAMEB==============
nsel_cols=c("Continent","ExacerbatorState","Severity")
region<-"Continent"
abundance_analysis(cameb,nsel_cols,region,1)
