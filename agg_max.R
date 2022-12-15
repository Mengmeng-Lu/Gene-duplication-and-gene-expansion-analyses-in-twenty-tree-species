print(files<-list.files(pattern="*.tmp2"))

da<-read.table(files[1],header=T)

agg<-aggregate(da$TPM,by = list(da$gene),FUN =max)

write.table(agg, file="max.txt", quote=FALSE, row.names=FALSE, sep="\t")

quit()
