#data directory is expected within the work directory

#work directory variable
#wkdir <- "/Users/yizhuoma/Desktop/312/"
wkdir <- "~/cphg/pTyrSignalComparison/"

#create results folder
dir.create(file.path(wkdir, "results"), showWarnings = FALSE)

#read in data
ptyr <- read.csv(paste0(wkdir,"data/barcode.csv"))

ptyr <- ptyr[ptyr$Status!='Total',]
ptyr$Status <-factor(ptyr$Status)
statuslist <- unique(ptyr$Status)

#statuslist<- statuslist[statuslist != "Total"]



titleprefixes <-c("Int_n_Bk_n_A","Int_n_Bk", "Int_n_A_n_Bk")
blank.frame <-data.frame(Int_n_Bk_n_A = numeric(), Int_n_Bk = numeric(), Int_n_A_n_Bk= numeric(), 
                         Sample.ID = numeric(), Family_ID = character(), Status=character(), Gel = numeric())
whole.frame <- blank.frame
for (status in statuslist){
  filled.frame <- blank.frame
  status.frame <- ptyr[ptyr$Status==status,]
  for (i in seq(1,8)){ 
    subtable <- status.frame[,c(paste0(titleprefixes,".G",i),"Sample.ID", "Family_ID","Status")]
    subtable$Gel <- i
    colnames(subtable) <- colnames(filled.frame)
    head(subtable)
    filled.frame <- rbind(filled.frame,subtable)
    whole.frame <-rbind(whole.frame,subtable)
  }
  for (i in seq(1,3)){
    titleprefix <- titleprefixes[i]
  pdf(paste0(wkdir,"results/pTyrSignalling_Boxplots_",status,titleprefix,".pdf"),width=11,height=8, title=paste("pTyr Signalling -",status,titleprefix))
  plot(log(filled.frame[,c(titleprefix)],base=2) ~ as.factor(filled.frame$Sample.ID),
       ylab=paste("log2(Normalized Intensity)",titleprefix), xlab="Sample ID",main=paste("pTyr Signalling -",status))
  points(log(filled.frame[,titleprefix],base=2) ~ as.factor(filled.frame$Sample.ID),col=filled.frame$Gel,pch=1)
  
  legend('topright',paste("Gel",c(unique(filled.frame$Gel))),col=unique(filled.frame$Gel),pch=1,cex=.7)
  dev.off()
  }
}



samplelist <- unique(whole.frame$Sample.ID)
for (sample in samplelist){
  for (i in seq(1,3)){
    titleprefix <- titleprefixes[i]

    pdf(paste0(wkdir,"results/pTyrSignalling_Boxplots_Sample",sample,"_",titleprefix,".pdf"),width=11,height=8, title=paste("pTyr Signalling - Sample",sample,titleprefix))
    subplot <- whole.frame[whole.frame$Sample.ID==sample,c(titleprefix,"Sample.ID","Status","Gel")]
    plot(log(subplot[,c(titleprefix)],base=2) ~ as.factor(subplot$Status),
         ylab=paste("log2(Normalized Intensity)",titleprefix), xlab="Status",
         main=paste("pTyr Signalling - Sample",sample))
    points(log(subplot[,c(titleprefix)],base=2) ~ as.factor(subplot$Status),col=subplot$Gel)
    legend('topright',paste("Gel",c(unique(subplot$Gel))),col=unique(subplot$Gel),pch=1,cex=.7)
    dev.off()
  }
}


