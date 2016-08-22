#' Penalty
#'
#' \code{penalty} returns value of penalty.
#'
#' @param x x
#' @param penalty_method character specifying which algorithm to use when
#'   calculating the penalty. Default is "THRESHOLD" with other options "RIDGE"
#'   and "LASSO".
#'
#' @return value
penalty <- function(x, penalty_method = "THRESHOLD") {
  if(penalty_method == "THRESHOLD") {
    sumx <- sum(x)
    a <- sumx ** 10
    b <- 0.5**10
    value <- ALPHA * a/(a + b)
  } else if(penalty_method=="RIDGE"){
    value <- ALPHA * sum(x * x) # ridge regression
  } else if(penalty_method == "LASSO"){
    value <- ALPHA * sum(abs(x)) # LASSO regression
  } else {
    stop("Don't know how to handle penalty method ", penalty_method,
         call. = FALSE)
  }
  return(value)
}
