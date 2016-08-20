#' Receptor Score
#'
#' \code{receptor_score} calculates the receptor score.
#'
#' @param x x
#'
#' @return score
receptor_score <- function(x) {
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
  score <- score*AUCSCALE2
  return(score)
}
