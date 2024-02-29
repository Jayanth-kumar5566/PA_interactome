type="species" #or species (specify here)

#EMBARC
reticulate::source_python("function_embarc-cleanup.py")
emb<-get_embarc_data(type)
rm(list = setdiff(ls(),c("emb")))

#CAMEB2
library(phyloseq)
physeq <- readRDS("./../Data/CAMEB2/analysis/KAIJU/ps_Genus.RData")
otu_df <- as.data.frame(otu_table(physeq))
sample_df <- as.data.frame(sample_data(physeq))
#Filtering and merging OTUs with metadata


rm(list = setdiff(ls(),c("emb")))
