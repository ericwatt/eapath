if(getRversion() >= "2.15.1"){
  utils::globalVariables(c("modl_ga", "modl_tp", "hitc", "aenm"))
}

#' Cast tcpl output to model format
#'
#' \code{tcpl_to_model_dat} preps tcpl output for model input.
#'
#' @param dat output from tcpl level 5 data
#' @param pathway string, specify ER or AR
#'
#' @details # This function is to take a pipeline formatted data.table
#' (long format, one m4id per row)
#' and convert to the form needed by the ER model
#' (one chemical per row, multiple columns for assays)
#' Requires a tcplPrepOtpt(tcplLoadData()) formatted data.table
#' also requires an assay_order (list of assay) so that NAs can be converted
#' assumed already subset (one unique row per code)
#'
#' @return dat_cast a data.table cast into the correct format for the model
#'
#' @import data.table
#' @export
tcpl_to_model_dat <- function(dat, pathway) {
  if (pathway == "ER"){
    assay_order <- c("NVS_NR_bER", "NVS_NR_hER", "NVS_NR_mERa", "OT_ER_ERaERa_0480",
                     "OT_ER_ERaERa_1440", "OT_ER_ERaERb_0480", "OT_ER_ERaERb_1440",
                     "OT_ER_ERbERb_0480", "OT_ER_ERbERb_1440", "OT_ERa_EREGFP_0120",
                     "OT_ERa_EREGFP_0480", "ATG_ERa_TRANS_up", "ATG_ERE_CIS_up",
                     "TOX21_ERa_BLA_Agonist_ratio", "TOX21_ERa_LUC_BG1_Agonist",
                     "ACEA_T47D_80hr_Positive", "TOX21_ERa_BLA_Antagonist_ratio",
                     "TOX21_ERa_LUC_BG1_Antagonist")
    modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
    modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
    modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")
  } else if (pathway == "AR"){
    assay_order <- c("NVS_NR_hAR", "NVS_NR_cAR", "NVS_NR_rAR", "OT_AR_ARSRC1_0480",
                     "OT_AR_ARSRC1_0960", "OT_AR_ARELUC_AG_1440", "ATG_AR_TRANS_up",
                     "TOX21_AR_BLA_Agonist_ratio", "TOX21_AR_LUC_MDAKB2_Agonist",
                     "TOX21_AR_BLA_Antagonist_ratio", "TOX21_AR_LUC_MDAKB2_Antagonist2")
    modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
    modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
    modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")
  } else {
    stop("Pathway ", pathway, " is not recognized",
         call. = FALSE)
  }
  dat <- copy(dat)
  dat[, modl_ga := 10^(modl_ga)] #convert from log to uM
  dat[!(hitc == 1), `:=` (modl_ga = 1000000,
                          modl_tp = 0,
                          modl_gw = 1)]
  dat[modl_tp > 1000, modl_tp := 0]
  dat[aenm %in% c("ATG_ERa_TRANS_up", "ATG_ERE_CIS_up", "ATG_AR_TRANS_up"),
      modl_tp := modl_tp * 25]
  dat[, modl_tp := modl_tp / 100]
  dat[modl_tp > 1, modl_tp := 1]

  #modl_ga column names
  modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
  modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
  modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")

  # Cast so one chemical per line ----------

  dat_cast <- dcast(dat, code + chnm ~ aenm, value.var=c("modl_tp", "modl_ga","modl_gw"))
  for (col in modl_ga_cols) dat_cast[is.na(get(col)), (col) := 1000000]
  for (col in modl_tp_cols) dat_cast[is.na(get(col)), (col) := 0]
  for (col in modl_gw_cols) dat_cast[is.na(get(col)), (col) := 1]
  return(dat_cast)
}
