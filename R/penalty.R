#' Penalty
#'
#' \code{penalty} returns value of penalty.
#'
#' @param x x
#'
#' @return value
penalty <- function(x) {
  if(PENALTY.METHOD=="RIDGE") value <- ALPHA * sum(x*x) # ridge regression
  if(PENALTY.METHOD=="LASSO") value <- ALPHA * sum(abs(x)) # LASSO regression
  if(PENALTY.METHOD=="THRESHOLD") {
    sumx <- sum(x)
    a <- sumx**10
    b <- 0.5**10
    value <- ALPHA * a/(a+b)
  }
  return(value)
}
