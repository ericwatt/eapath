#' Calculate the least squares solution for one chemical
#'
#' \code{er_model} calculates least squares solution
#'
#' @param adata cr.mat from \code{prepCR}
#' @param do.debug logical to run in debug mode. Default F
#' @param xmin.plot numeric. Default 0.01
#'
#' @importFrom stats optim
#'
#' @return resmat matrix[nconc rows x NRECEPTOR columns]
er_model <- function(adata,do.debug=F,xmin.plot=0.01) {
    nconc <- length(CONCLIST)
    nassay <- NASSAY
    adata <- as.data.frame(t(adata))
    adata <- cbind(adata,tmat_va())
    conc.names <- c()
    for(i in 1:NCONC) conc.names <- c(conc.names,paste("C",i,sep=""))
    t.names <- c()
    for(i in 1:NRECEPTOR) t.names <- c(t.names,paste("T",i,sep=""))
    names(adata) <- c(conc.names,t.names)
    nuse <- NCONC

    temp <- adata[1,1:NCONC]
    a1 <- as.numeric(temp[1:nuse])
    xlist <- CONCLIST
    anames <- c()
    for(i in 1:NASSAY) anames <- c(anames,paste("A",i,sep=""))
    counter <- 1

    # calculate the model

    resmat <- as.data.frame(matrix(nrow=NCONC,ncol=NRECEPTOR))
    allrnames <- c()
    for(i in 1:NRECEPTOR) allrnames <- c(allrnames,paste("R",i,sep=""))
    names(resmat) <- allrnames
    resmat[] <- 0
    start <- vector(mode="numeric",length=NRECEPTOR)
    lwr   <- vector(mode="numeric",length=NRECEPTOR)
    upr   <- vector(mode="numeric",length=NRECEPTOR)
    start[] <- 0
    lwr[] <- 0
    upr[] <- 1
    for(i in 1:NCONC) {
        concname <- paste("C",i,sep="")
        A <- adata[,c(concname,t.names)]
        if(i>1) start <- res$par
        if(do.debug){
            res <- optim(par     = start,
                         f       = afr_va,
                         A       = A,
                         method  = "L-BFGS-B",
                         lower   = lwr,
                         upper   = upr,
                         control = list(maxit=2000))
        }else{
            res <- optim(par     = start,
                         f       = afr_va,
                         A       = A,
                         method  = "L-BFGS-B",
                         lower   = lwr,
                         upper   = upr,
                         control = list(maxit=2000))
        }
        for(j in 1:NRECEPTOR) resmat[i,j] <- res$par[j]*AUCSCALE1
        if(res$convergence!=0 || do.debug) cat(i,"Convergence: ",res$convergence," Calls: ",res$counts," residual: ",res$value," : ",res$message,"\n")
        if(do.debug) print(res$par)
    }
    return(resmat)
}
