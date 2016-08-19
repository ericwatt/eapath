if(getRversion() >= "2.15.1"){
    utils::globalVariables(c("code", "modl_ga", "boot_hitc", "modl_tp", "aenm",
                             "old_code", "spid"))
}

#' Cast tcpl output to model format
#'
#' \code{tcpl_to_model_dat} preps toxboot output for model input.
#'
#' @param dat output from \code{toxbootHitParamCI} data
#' @param assay_order order of assays
#'
#' @details # This function is to take a toxbootHitParamCI formatted data.table
#' (long format, one m4id bootstrap replicate per row)
#' and convert to the form needed by the ER model
#' (one chemical boostrap replicate per row, multiple columns for assays)
#' Requires an assay_order (list of assay) so that NAs can be converted
#' assumed already subset (one unique row per code)
#'
#' @return dat_cast a data.table cast into the correct format for the model
#'
#' @import data.table
tcpl_to_model_dat_boot <- function(dat, assay_order) {
    dat[, modl_ga := 10^(modl_ga)] #convert from log to uM
    dat[!(boot_hitc == 1), `:=` (modl_ga = 1000000,
                                 modl_tp = 0,
                                 modl_gw = 1)]
    dat[modl_tp > 1000, modl_tp := 0]
    dat[aenm %in% c("ATG_ERa_TRANS_up", "ATG_ERE_CIS_up"), modl_tp := modl_tp * 25]
    dat[, modl_tp := modl_tp / 100]
    dat[modl_tp > 1, modl_tp := 1]

    #modl_ga column names
    modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
    modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
    modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")

    # Cast so one chemical per line ----------

    dat[, old_code := code]
    dat[, replicate := 1:length(spid), by = "m4id"]
    dat[, code := paste(code, replicate, sep="_")]

    dat_cast <- dcast(dat, code + chnm + old_code ~ aenm, value.var=c("modl_tp", "modl_ga", "modl_gw"))
    for (col in modl_ga_cols) dat_cast[is.na(get(col)), (col) := 1000000]
    for (col in modl_tp_cols) dat_cast[is.na(get(col)), (col) := 0]
    for (col in modl_gw_cols) dat_cast[is.na(get(col)), (col) := 1]
    return(dat_cast)
}
