ptyr <- read.csv("/Users/Jessica/pTyr/barcode.csv")

statuslist <- unique(ptyr$Status)


titleprefix <-"Int_n_Bk_n_A"
blank.frame <-data.frame(Int_n_Bk_n_A = numeric(), Sample.ID = numeric(), Gel = numeric())

for (status in statuslist){
  filled.frame <- blank.frame
  status.frame <- ptyr[ptyr$Status==status,]
  
  for (i in seq(1,8)){ 
    subtable <- status.frame[,c(paste0(titleprefix,".G",i),"Sample.ID")]
    subtable$Gel <- i
    colnames(subtable) <- colnames(filled.frame)
    head(subtable)
    filled.frame <- rbind(filled.frame,subtable)
  }
  pdf(paste0("/Users/Jessica/pTyr/pTyrSignalling_Boxplots_",status,".pdf"),width=11,height=8, title=paste("pTyr Signalling -",status))
  plot(filled.frame[,c(titleprefix)] ~ as.factor(filled.frame$Sample.ID),ylab="Normalized Intensity", xlab="Sample ID",main=paste("pTyr Signalling -",status))
  points(filled.frame[,titleprefix] ~ as.factor(filled.frame$Sample.ID),col=filled.frame$Gel)
  
  legend('topright',paste("Gel",c(unique(filled.frame$Gel))),col=unique(filled.frame$Gel),pch=1,cex=.7)
  dev.off()
  
}
