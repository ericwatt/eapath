#' Calculate the area under the curve
#'
#' \code{AUCcalc} calculates the AUC values.
#'
#' @param resmat matrix[nconc rows x NRECEPTOR columns]
#'
#' @return auc numeric vector length NRECEPTOR of AUC values
AUCcalc <- function(resmat) {
  auc <- vector(mode="numeric",length=NRECEPTOR)
  for(i in 1:NRECEPTOR) auc[i] <- receptor_score(resmat[,i])
  return(auc)
}
