library(data.table)

n <- 10000000
DT <- data.table(chunk=rep(0:1, c(n/2,n/2)), x1=rep(c(paste(rep(strrep("X",20),5), collapse=" "),
                                                      paste(rep(strrep("Y",20),5), collapse=" ")), c(n/2,n/2)))

DT2 <- rbindlist(lapply(split(DT, by="chunk", keep.by=FALSE), function(x) {
    x[, c("x1", "x2", "x3", "x4", "y") := tstrsplit(x1, " ", fixed=TRUE)]
}))

DT[, c("x1", "x2", "x3", "x4", "y") := tstrsplit(x1, " ", fixed=TRUE)][, chunk:=NULL]