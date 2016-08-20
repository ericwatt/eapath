#' \code{prepCR} preps the concentration-response matrix for a single chemical
#'
#' @param dat data.table
#' @param chem value of \code{code} column to specify the row
#'
#' @details ac50,top,w are vectors of length 18 with values for one instance of one chemical
#'
#' expect top in range [0,100]
#' ATG = log foldchange top * 25
#'
#' @return cr.mat matrix This returns the concentration-response matrix
prepCR <- function(dat, chem) {
  ac50 <- as.numeric(dat[code == chem, modl_ga_cols, with = FALSE])
  top  <- as.numeric(dat[code == chem, modl_tp_cols, with = FALSE])
  w    <- as.numeric(dat[code == chem, modl_gw_cols, with = FALSE])
  #top[is.na(top)] <- 0
  #w[is.na(w)] <- 1
  #ac50[is.na(ac50)] <- 1000000
  #top[top>1] <- 1
  cr.mat <- matrix(nrow=length(CONCLIST),ncol=NASSAY)
  cr.mat[] <- 0
  for(i in 1:length(CONCLIST)) {
    conc <- CONCLIST[i]
    for(j in 1:NASSAY) {
      ac50j <- as.numeric(ac50[j])
      tj <- as.numeric(top[j])
      wj <- as.numeric(w[j])
      cr.mat[i,j] <- tj*(conc**wj/(conc**wj+ac50j**wj))
    }
  }

  return(cr.mat)
}
