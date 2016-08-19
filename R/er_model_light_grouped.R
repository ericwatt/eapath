# dat: data.table returned by tcpl_to_model_dat()
# group: column name such that dat[group == value]
#   will result in a data table with column code
#   having multiple rows.
# value: value to subset the group column by
# This is implemented to give bigger chunks to each
#   core in mclapply so that the scheduler is not
#   overburdened.

er_model_light_grouped <- function(dat, group, value){
    #dat_group <- dat[get(group) == value]
    codes <- dat[get(group) == value, code]
    dat_auc <- lapply(codes, er_model_light, dat = dat) %>% rbindlist
    return(dat_auc)
}
