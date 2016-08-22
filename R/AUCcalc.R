#' Calculate the area under the curve
#'
#' \code{AUCcalc} calculates the AUC values.
#'
#' @param resmat matrix[nconc rows x nreceptor columns]
#'
#' @return auc numeric vector length nreceptor of AUC values
AUCcalc <- function(resmat, pathway, aucscale2 = NULL) {
  nreceptor <- ncol(resmat)
  auc <- vector(mode="numeric",length=nreceptor)
  for(i in 1:nreceptor) auc[i] <- receptor_score(resmat[,i], pathway, aucscale2)
  return(auc)
}
