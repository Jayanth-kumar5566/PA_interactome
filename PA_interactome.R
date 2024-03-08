# PA interactome specific co-occuerence analysis
source("Microbiome_data_processing.R")

#============CAMEB==============
nsel_cols=c("Continent","ExacerbatorState","Severity")
table(cameb$Continent)
asia_data<-subset(cameb,cameb$Continent=="Asia",select = -which(colnames(cameb) %in% nsel_cols))
europe_data<-subset(cameb,cameb$Continent=="Europe",select = -which(colnames(cameb) %in% nsel_cols))


source("Network_analysis/correlation_network.R")
asia_res<-correlation_network(asia_data,cut_off=TRUE,lioness=FALSE)
europe_res<-correlation_network(europe_data,cut_off=TRUE,lioness=FALSE)

asia_res["Pseudomonas aeruginosa",]
europe_res["Pseudomonas aeruginosa",]

#PA in asia is all 0, compared to Europe? -- seriously??

#======Try GBLM=======
abs(cor(asia_data,method = "spearman")["Pseudomonas aeruginosa",])>0.3
# I see, maybe due to the 0.3 cut-off, very low strength of PA interaction

#Run 2 by removing the 0.3 cut-off -- have done that, can get some result by removing it
asia_res<-correlation_network(asia_data,cut_off=FALSE,lioness=FALSE)
