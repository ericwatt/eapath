#' Penalty
#'
#' \code{penalty} returns value of penalty.
#'
#' @param x x
#' @param pathway character flag for 'ER' or 'AR' models
#' @param penalty_method character specifying which algorithm to use when
#'   calculating the penalty. Default is "THRESHOLD" with other options "RIDGE"
#'   and "LASSO".
#' @param alpha numeric with default NULL which gets set to 1 for ER model or
#'   0.05 for AR model
#'
#' @return value
penalty <- function(x, pathway, penalty_method = "THRESHOLD", alpha = NULL) {
  if (is.null(alpha)) {
    if(pathway == "ER"){
      alpha <- 1
    } else if (pathway == "AR"){
      alpha <- 0.05
    } else {
      stop("Pathway ", pathway, " is not recognized",
           call. = FALSE)
    }
  }
  if(penalty_method == "THRESHOLD") {
    sumx <- sum(x)
    a <- sumx ** 10
    b <- 0.5**10
    value <- alpha * a/(a + b)
  } else if(penalty_method=="RIDGE"){
    value <- alpha * sum(x * x) # ridge regression
  } else if(penalty_method == "LASSO"){
    value <- alpha * sum(abs(x)) # LASSO regression
  } else {
    stop("Don't know how to handle penalty_method ", penalty_method,
         call. = FALSE)
  }
  return(value)
}
