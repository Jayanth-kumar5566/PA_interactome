type="species" #or species (specify here)
emb_cols=c("European_Region","FrequentExacerbator","Severity") #Choose from embarc metadata
cameb_cols=c("Continent","ExacerbatorState","Severity")
matched_cameb=TRUE

#EMBARC
reticulate::source_python("function_embarc-cleanup.py")
emb<-get_embarc_data(type,emb_cols)
rm(list = setdiff(ls(),c("emb","cameb_cols","type","matched_cameb")))

#CAMEB2
library(phyloseq)
# Capitalize the first letter
capitalized_type <- sub("^\\w", toupper(substr(type, 1, 1)), type)
physeq <- readRDS(paste0("./../Data/CAMEB2/analysis/KAIJU/ps_",capitalized_type,".RData"))
otu_df <- as.data.frame(otu_table(physeq))
sample_df <- as.data.frame(sample_data(physeq))
if(matched_cameb==TRUE){
  ind<-subset(sample_df,sample_df$Matching=="Matched")
  sample_df<-sample_df[ind$SampleID,]
  otu_df<-otu_df[ind$SampleID,]
}
#Filtering and merging OTUs with metadata
all(row.names(otu_df)==row.names(sample_df))
ind<-(colSums((otu_df/rowSums(otu_df))>0.01)>0.05*(dim(sample_df)[1])) #1% in 5% of the patients
cameb<-cbind(otu_df[,ind],sample_df[,cameb_cols])

rm(list = setdiff(ls(),c("emb","cameb")))