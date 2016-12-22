if(getRversion() >= "2.15.1"){
  utils::globalVariables(c("aenm_cor", "modl_ga_via"))
}

#' Filter hit calls in AR dataset by antagonist viability
#'
#' \code{via_filter} removes the hit call for AR antagonist assays if the
#' viability assay is a more potent hit.
#'
#' @param dat data.table with AR assay results
#' @param dat_via data.table with TOX21_AR_BLA_Antagonist_viability and
#'   TOX21_AR_LUC_MDAKB2_Antagonist2_viability results
#'
#' @import data.table
#'
#' @return dat_via_filt, which is input data.table dat with added column
#'   modl_ga_via and hitc for TOX21_AR_BLA_Antagonist_ratio and
#'   TOX21_AR_LUC_MDAKB2_Antagonist2 assays changed to 0 if viability result is
#'   more potent.
#'
#' @export
via_filter <- function(dat, dat_via){
  dat_via <- copy(dat_via)
  dat_via[!(hitc == 1), modl_ga := 3]
  dat_via[aenm == "TOX21_AR_BLA_Antagonist_viability",
          aenm_cor := "TOX21_AR_BLA_Antagonist_ratio"]
  dat_via[aenm == "TOX21_AR_LUC_MDAKB2_Antagonist2_viability",
          aenm_cor := "TOX21_AR_LUC_MDAKB2_Antagonist2"]
  dat_via_filt <- merge(dat,
                        dat_via[, list(code, aenm_cor, modl_ga_via = modl_ga)],
                        by.x = c("code", "aenm"),
                        by.y = c("code", "aenm_cor"),
                        all.x = TRUE)
  dat_via_filt[hitc == 1L & modl_ga > modl_ga_via, hitc := 0]
  return(dat_via_filt[])
}
