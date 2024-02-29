def get_embarc_data(type_):
  import pandas
  import numpy
  #Meta data
  df=pandas.read_csv("./../Data/EMBARC_data/metadata/metadata_subset/metadata_subset.csv")
  
  print("We are intersted in the regional differences - Below is the number of patietns in each region")
  
  print(df.loc[:,"European_Region"].value_counts())
  
  
  print("By country")
  
  print(df.loc[:,"Centre"].value_counts())
  
  # To do merge the London, Dundee as UK
  # Do similar stuff with the rest of the countries listed above
  
  
  # What is the identifier that is common with the sequencing data
  
  micro=pandas.read_csv("./../Data/EMBARC_data/kaiju_"+str(type_)+"_aggregate.csv",index_col=0)
  
  
  a=set(df.loc[:,"Sequencing.ID"].values)
  b=set(micro.index)
  
  print("meta data available",len(a))
  print("microbiome data available",len(b))
  
  
  print("Both available",len(b.intersection(a)))
  
  
  #=======Data cleanup==========
  micro=micro.loc[df.loc[:,"Sequencing.ID"].values,:]
  
  #=====Add filtering======
  rel_abund=micro.div(micro.sum(axis=1),axis=0)
  sel_ind=(rel_abund>0.01).sum(axis=0)>(0.05*micro.shape[0])
  micro=micro.loc[:,sel_ind]
  
  #======Add region and other variables to the micro file======
  micro.loc[:,["European_Region","FrequentExacerbator","Severity"]]=df.loc[:,["European_Region","FrequentExacerbator","Severity"]].values
  return(micro)
