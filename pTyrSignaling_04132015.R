#install !!!! 1.9.5 !!!! (which is in development as of 4/13/15) - instructions to install here:
# https://github.com/Rdatatable/data.table/wiki/Installation
library(data.table)#v1.9.5+

#data directory is expected within the work directory

#work directory variable
wkdir <- "/Users/yizhuoma/pTyrSignalComparison/"
#wkdir <- "~/cphg/pTyrSignalComparison/"

#How Many Gels?
gelcount=8

#create results folder
dir.create(file.path(wkdir, "results"), showWarnings = FALSE)

#read in data
ptyr <- read.csv(paste0(wkdir,"data/barcode.csv"),header=TRUE)

head(ptyr)

#Make changes to master table
ptyr$Family_ID <- as.character(ptyr$Family_ID)
ptyr$Analytic_ID <- as.character(ptyr$Analytic_ID)
#ptyr <- ptyr[ptyr$Status!='Total',]
#ptyr$Status <-factor(ptyr$Status)
statuslist <- unique(ptyr$Status)

#statuslist<- statuslist[statuslist != "Total"]


titleprefixes <-c("Int_n_Bk_n_A","Int_n_Bk", "Int_n_A_n_Bk")
non_intensity_cols <- c("Sample.ID", "Family_ID","Analytic_ID","Status")

#Rearrange Table into first desired form

#retrieve column indices for each titleprefix

prefixindices1<-grep(paste0("^",titleprefixes[1],"\\."),colnames(ptyr))
prefixindices2<-grep(paste0("^",titleprefixes[2],"\\."),colnames(ptyr))
prefixindices3<-grep(paste0("^",titleprefixes[3],"\\."),colnames(ptyr))

longptyr<-melt(setDT(ptyr), id.vars = c("Sample.ID", "Family_ID","Analytic_ID","Status"), measure.vars =list(c(prefixindices1),c(prefixindices2),c(prefixindices3)) ,value.name=c("Int_n_Bk_n_A","Int_n_Bk", "Int_n_A_n_Bk"), variable.name='Gel')
View(longptyr)
#prefixindices=c()
#for (pre in 1:length(titleprefixes)){
#  prefixindices<-c(grep(paste0("^",titleprefixes[pre],"\\."),colnames(ptyr)))
#}
#prefixindices

