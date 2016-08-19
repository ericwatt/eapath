#' Function minimized in model
#'
#' \code{afr_va} is the function passed to \code{optim} in \code{er_model}.
#'
#' @param x x
#' @param A A matrix
#'
#' @return eret
afr_va <- function(x,A) {
    Ameas <- A[,1]
    nassay <- NASSAY
    F <- as.matrix(A[,2:(NRECEPTOR+1)])
    R <- matrix(nrow=NRECEPTOR,ncol=1)
    R[] <- x
    Apred <- F%*%R
    w <- vector(mode="numeric",length=NASSAY)
    w[] <- 1
    w[1] <- 1/3
    w[2] <- 1/3
    w[3] <- 1/3
    w[4] <- 1/6
    w[5] <- 1/6
    w[6] <- 1/6
    w[7] <- 1/6
    w[8] <- 1/6
    w[9] <- 1/6
    w[10] <- 1/2
    w[11] <- 1/2
    w[12] <- 1/2
    w[13] <- 1/2
    w[14] <- 1/2
    w[15] <- 1/2
    w[16] <- 1/1
    w[17] <- 1/2
    w[18] <- 1/2

    #w[] <- 1

    eret <- 0
    bot <- 0
    top <- 0
    mask <- Ameas
    mask[] <- 1
    mask[is.na(Ameas)] <- 0
    for(i in 1:nassay) {
        if(mask[i]==1) {
            top <- top + w[i] * (Apred[i]-Ameas[i])**2
            bot <- bot + w[i]
        }
    }
    eret <- top/bot/sum(mask) + penalty(R)
    return(eret)
}
