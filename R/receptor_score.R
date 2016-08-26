#' Receptor Score
#'
#' \code{receptor_score} calculates the receptor score.
#'
#' @param x x
#' @param pathway ER or AR
#' @param aucscale2 Default of NULL will be reset to pathway specific defaults
#'   for scaling AUC values
#'
#' @return score
receptor_score <- function(x, pathway, aucscale2 = NULL) {
  if (pathway == "ER"){
    if (is.null(aucscale2)) aucscale2 <- 1.24
  } else if (pathway == "AR"){
    if (is.null(aucscale2)) aucscale2 <- 1
  } else {
    stop("Pathway ", pathway, " is not recognized",
         call. = FALSE)
  }

  nuse <- length(x)
  if(nuse<2) return(0)
  score <- x[1]
  for(i in 2:nuse) {
    slope.sign <- 1
    delta <- x[i]-x[i-1]
    if(delta < -0.01) slope.sign <- -1
    score <- score + slope.sign*x[i]
  }
  score <- score/nuse
  if(score<0) score <- 0
  score <- score*aucscale2
  return(score)
}
