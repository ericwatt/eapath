# calculate the area under the curve
# resmat = matrix[nconc rows x NRECEPTOR columns]

AUCcalc <- function(resmat) {
    auc <- vector(mode="numeric",length=NRECEPTOR)
    for(i in 1:NRECEPTOR) auc[i] <- receptor_score(resmat[,i])
    return(auc)
}
