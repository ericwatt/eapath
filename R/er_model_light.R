er_model_light <- function(dat, chem){
    dat_auc <- prepCR(dat, chem) %>%
        er_model %>%
        AUCcalc %>%
        as.list %>%
        as.data.table
    dat_auc[, code := chem]
    return(dat_auc)
}
