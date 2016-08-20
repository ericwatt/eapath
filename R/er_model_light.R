if(getRversion() >= "2.15.1")  utils::globalVariables(c("code"))

#' ER Model Light
#'
#' \code{er_model_light} combines the returns AUC values for a tcpl input.
#'
#' @param dat data.table returned by \code{tcpl_to_model_dat}
#' @param chem the value of column code to specify the row to perform the calculation on.
#'
#' @return dat_auc data.table of AUC values
#' @import data.table
#' @export
er_model_light <- function(dat, chem){
  dat_auc <- as.data.table(
    as.list(
      AUCcalc(
        er_model(
          prepCR(dat, chem)
        )
      )
    )
  )
  dat_auc[, code := chem]
  return(dat_auc)
}
