#wkdir <- "/Users/yizhuoma/Desktop/312/"
wkdir <- "~/cphg/pTyrSignalComparison/"
ptyr <- read.csv(paste0(wkdir,"barcode.csv"))

statuslist <- unique(ptyr$Status)
statuslist<- statuslist[statuslist != "Total"]

titleprefixes <-c("Int_n_Bk_n_A","Int_n_Bk", "Int_n_A_n_Bk")
blank.frame <-data.frame(Int_n_Bk_n_A = numeric(), Int_n_Bk = numeric(), Int_n_A_n_Bk= numeric(), Sample.ID = numeric(), Gel = numeric())

for (status in statuslist){
  filled.frame <- blank.frame
  status.frame <- ptyr[ptyr$Status==status,]
  
  for (i in seq(1,8)){ 
    subtable <- status.frame[,c(paste0(titleprefixes,".G",i),"Sample.ID")]
    subtable$Gel <- i
    colnames(subtable) <- colnames(filled.frame)
    head(subtable)
    filled.frame <- rbind(filled.frame,subtable)
  }
  for (i in seq(1,3)){
    titleprefix <- titleprefixes[i]
  pdf(paste0(wkdir,"pTyrSignalling_Boxplots_",status,titleprefix,".pdf"),width=11,height=8, title=paste("pTyr Signalling -",status,titleprefix))
  plot(filled.frame[,c(titleprefix)] ~ as.factor(filled.frame$Sample.ID),ylab=paste("Normalized Intensity",titleprefix), xlab="Sample ID",main=paste("pTyr Signalling -",status))
  points(filled.frame[,titleprefix] ~ as.factor(filled.frame$Sample.ID),col=filled.frame$Gel)
  
  legend('topright',paste("Gel",c(unique(filled.frame$Gel))),col=unique(filled.frame$Gel),pch=1,cex=.7)
  dev.off()
  }
}
