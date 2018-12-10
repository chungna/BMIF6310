#title: "Proteomics_Merge_and_Match"
#author: "Nadjali Chung"
#date_due: "7 December 2018"


#Import filtered protein lists from Proteome Discoverer v2.2 output
Batch3<-read.csv("Descrp_IPL_Batch3_AllFrac&Repl_082318_2+PSMs.csv", header=TRUE)
Batch4<-read.csv("Descrp_IPL_Batch4_AllFrac&Repl_082318_2+PSMs.csv", header=TRUE)

#Merge to get intensities for all channels
merged<-merge(Batch3,Batch4, by=c("Description", "Accession"), all=FALSE, sort=FALSE,no.dups=TRUE,incomparables=NULL)

#Rename columns
colnames(merged)<-c("Description", "Accession", "B3-126", "B3-127N", "B3-127C","B3-128N", "B3-128C", "B3-pool", "B3-129C", "B3-130N", "B3-130C", "B3-131N", "B3-131C", "B4-126", "B4-poola", "B4-127C","B4-128N", "B4-poolb", "B4-129N", "B4-129C", "B4-130N", "B4-130C", "B4-131N", "B4-131C")

#Filter results that do not have Pool channel intensities, or <80% of the channels
filtered<-merged[!is.na(merged_des_acc_IPL$"B3-pool") & !is.na(merged_des_acc_IPL$"B4-poola") & !is.na(merged_des_acc_IPL$"B4-poolb"),]
write.csv(filtered, file="Quantifiable_IPL.csv",row.names=FALSE, na="")

#Calculate column sums
channel_sums<-colSums(Filter(is.numeric, filtered), na.rm=TRUE)
Normalize_p1<-rbind(filtered, c("NA", "NA", channel_sums))
