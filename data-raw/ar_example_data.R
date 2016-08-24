# Script to generate sample data to include with eapath
# this data represents what would be returned from the tcpl database
# to be used as input for the AR Pathway Model.

library(tcpl)
library(magrittr)
tcplConf(db = "invitrodb")

# Get aeids corresponding to AR assays

assays <- c("NVS_NR_hAR", "NVS_NR_cAR", "NVS_NR_rAR",
            "OT_AR_ARSRC1_0480", "OT_AR_ARSRC1_0960",
            "OT_AR_ARELUC_AG_1440", "ATG_AR_TRANS_up",
            "TOX21_AR_BLA_Agonist_ratio",
            "TOX21_AR_LUC_MDAKB2_Agonist",
            "TOX21_AR_BLA_Antagonist_ratio",
            "TOX21_AR_LUC_MDAKB2_Antagonist2")

aeid_table_full <- tcplLoadAeid(add.fld = c("asid", "asnm"))
aeids <- aeid_table_full[aenm %in% assays, aeid]

dat_L5 <- tcplLoadData(lvl = 5L, fld = "aeid", val = aeids, type = "mc") %>%
    tcplPrepOtpt %>%
    tcplSubsetChid

ar_L5_prod_ext_v2 <- dat_L5[, .(chnm, code, m4id, aenm, aeid, hitc, modl_ga, modl_gw, modl_tp)]

devtools::use_data(ar_L5_prod_ext_v2, overwrite = TRUE)
