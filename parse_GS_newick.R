rm(list=ls())
parseGS<-function(newick,OTUList=NULL,output=NULL){
  # newick<-"seq_BLOSUM62_11_1_blast_GSP.nwk copy"
  # OTUList<-NULL
  OTUList<-"seq_BLOSUM62_11_1_blast_simple.txt"
  if (!is.null(OTUList)){
    dict<-read.delim(OTUList,header=F,quote="",sep = "\t",stringsAsFactors = F)
    dict$V1<-as.character(dict$V1)
    dict$V2<-gsub(",",".",dict$V2,fixed = T)
    dict$V2<-gsub(":",";",dict$V2,fixed = T)
  }
  
  data<-read.delim(newick,header=F,quote="",sep = "\t",stringsAsFactors = F)
  names(data)<-"Original"
  data$Split<-lapply(data$Original,function(x)(strsplit(x,":\\[|\\]")))
  myReplace<-function(entry){
    # temp<-data.frame(Split1=unlist(data$Split[1]),stringsAsFactors = F)
    
    temp<-data.frame(Split1=unlist(entry),stringsAsFactors = F)
    temp$mask1[grep("\\(|\\)",temp$Split1)]<-temp$Split1[grep("\\(|\\)",temp$Split1)]
    # temp$Split2[!is.na(temp$mask1)]<-lapply(temp$mask1[!is.na(temp$mask1)],function(x)(strsplit(x,"\\(|,|\\)")))
    temp$Split2<-lapply(temp$mask1,function(x)(strsplit(x,"[\\(|,|\\|;)]+")))
    temp$mask2<-lapply(temp$mask1,function(x)(strsplit(x,"[0-9]+")))
    temp$Replace1<-lapply(temp$Split2,
                          function(x){
                            if (is.null(OTUList)) return(x)
                            else{
                              y<-dict$V2[match(unlist(x),dict$V1)]
                              y[is.na(y)]<-""
                              return(list(y))
                            }
                          })
    temp$Replace2<-mapply(
      function(x,y){
        paste0(c(rbind(unlist(y),unlist(x))),collapse = "")
        },temp$mask2,temp$Replace1)
    temp$Replace2[is.na(temp$mask1)]<-temp$Split1[is.na(temp$mask1)]
    return(paste0(temp$Replace2,collapse = ""))
  }
  data$Replace<-sapply(data$Split,myReplace)
  
  if (is.null(output)) output<-paste0("Parsed-",newick)
  write.table(data$Replace,output,quote = F,row.names = F,col.names = F) 
}