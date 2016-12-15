if(getRversion() >= "2.15.1")  utils::globalVariables(c("code"))

#' ER Model Light Grouped
#'
#' \code{er_model_light_grouped} wraps the function \code{er_model_light} in
#' lapply to calculate many rows subset by the value of parameter value of
#' column group.
#'
#' @param dat data.table returned by \code{tcpl_to_model_dat}
#' @param group column name such that dat[group == value] will result in a data
#'   table with column code having multiple rows.
#' @param value value to subset the group column by
#' @param pathway specify ER or AR
#'
#' @details This is implemented to give bigger chunks to each core in mclapply
#'   so that the scheduler is not overburdened.
#'
#'
#' @return dat_auc data.table of AUC values
#' @import data.table
#' @export
er_model_light_grouped <- function(dat, group, value, pathway){
  codes <- dat[get(group) == value, code]
  dat_auc <- rbindlist(lapply(codes,
                              er_model_light,
                              dat = dat,
                              pathway = pathway))
  return(dat_auc)
}
