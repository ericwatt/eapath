#' \code{prepCR} preps the concentration-response matrix for a single chemical
#'
#' @param dat data.table
#' @param chem value of \code{code} column to specify the row
#' @param conclist numeric vector
#' @param nassay integer length 1
#' @param modl_ga_cols character vector
#' @param modl_tp_cols character vector
#' @param modl_gw_cols character vector
#'
#' @details ac50,top,w are vectors of length 18 with values for one instance of one chemical
#'
#' expect top in range [0,100]
#' ATG = log foldchange top * 25
#'
#' @return cr.mat matrix This returns the concentration-response matrix
prepCR <- function(dat, chem, conclist, nassay, modl_ga_cols, modl_tp_cols, modl_gw_cols) {
  ac50 <- as.numeric(dat[code == chem, modl_ga_cols, with = FALSE])
  top  <- as.numeric(dat[code == chem, modl_tp_cols, with = FALSE])
  w    <- as.numeric(dat[code == chem, modl_gw_cols, with = FALSE])
  cr.mat <- matrix(data = 0, nrow = length(conclist), ncol = nassay)
  for(i in 1:length(conclist)) {
    conc <- conclist[i]
    for(j in 1:nassay) {
      ac50j <- as.numeric(ac50[j])
      tj <- as.numeric(top[j])
      wj <- as.numeric(w[j])
      cr.mat[i,j] <- tj*(conc**wj/(conc**wj+ac50j**wj))
    }
  }

  return(cr.mat)
}
