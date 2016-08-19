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
