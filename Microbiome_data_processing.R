type="species" #or species (specify here)
emb_cols=c("European_Region","FrequentExacerbator","Severity") #Choose from embarc metadata
cameb_cols=c("Continent","ExacerbatorState","Severity")

#EMBARC
reticulate::source_python("function_embarc-cleanup.py")
emb<-get_embarc_data(type,emb_cols)
rm(list = setdiff(ls(),c("emb","cameb_cols")))

#CAMEB2
library(phyloseq)
physeq <- readRDS("./../Data/CAMEB2/analysis/KAIJU/ps_Genus.RData")
otu_df <- as.data.frame(otu_table(physeq))
sample_df <- as.data.frame(sample_data(physeq))
#Filtering and merging OTUs with metadata
all(row.names(otu_df)==row.names(sample_df))
ind<-(colSums((otu_df/rowSums(otu_df))>0.01)>0.05*(dim(sample_df)[1])) #1% in 5% of the patients
cameb<-cbind(otu_df[,ind],sample_df[,cameb_cols])

rm(list = setdiff(ls(),c("emb","cameb")))