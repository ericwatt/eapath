# Script to generate sample data to include with eapath
# this data represents what would be returned from the tcpl database
# to be used as input for the ER Pathway Model.

library(tcpl)
library(magrittr)
tcplConf(db = "prod_external_invitrodb_v2")

# Get aeids corresponding to ER assays

assays <- c("NVS_NR_bER", "NVS_NR_hER", "NVS_NR_mERa", "OT_ER_ERaERa_0480",
            "OT_ER_ERaERa_1440", "OT_ER_ERaERb_0480", "OT_ER_ERaERb_1440",
            "OT_ER_ERbERb_0480", "OT_ER_ERbERb_1440", "OT_ERa_EREGFP_0120",
            "OT_ERa_EREGFP_0480", "ATG_ERa_TRANS_up", "ATG_ERE_CIS_up",
            "TOX21_ERa_BLA_Agonist_ratio", "TOX21_ERa_LUC_BG1_Agonist",
            "ACEA_T47D_80hr_Positive", "TOX21_ERa_BLA_Antagonist_ratio",
            "TOX21_ERa_LUC_BG1_Antagonist")

aeid_table_full <- tcplLoadAeid(add.fld = c("asid", "asnm"))
aeids <- aeid_table_full[aenm %in% assays, aeid]

dat_L5 <- tcplLoadData(lvl = 5L, fld = "aeid", val = aeids, type = "mc") %>%
    tcplPrepOtpt %>%
    tcplSubsetChid

er_L5_prod_ext_v2 <- dat_L5[, .(chnm, code, m4id, aenm, aeid, hitc, modl_ga, modl_gw, modl_tp)]

devtools::use_data(er_L5_prod_ext_v2, overwrite = TRUE)
