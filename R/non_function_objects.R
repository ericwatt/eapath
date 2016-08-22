PATHWAY <- "ER"
NASSAY <- 18
NRECEPTOR <- 9
NRECEPTOR0 <- 9
NRECEPTOR <- 26
SPECIFIC.AUC.CUTOFF <- 0.1

ALPHA <- 1
AUCSCALE1 <-  3.8  # put the top of the most active chemical to 1.0
AUCSCALE2 <-  1.24 # makes the top AUC==1.0

# Pathway-specific - stop

NCONC <- 45
CONCLIST <- c(1e-6,2.679636e-06,4.019455e-06,6.029182e-06,9.043773e-06,1.356566e-05,2.034849e-05,3.052273e-05,4.57841e-05,6.867615e-05,0.0001030142,0.0001545213,0.000231782,0.000347673,0.0005215095,0.0007822643,0.001173396,0.001760095,0.002640142,0.003960213,0.005940319,0.008910479,0.01336572,0.02004858,0.03007287,0.0451093,0.06766395,0.1014959,0.1522439,0.2283658,0.3425487,0.5138231,0.7707347,1.156102,1.734153,2.601229,3.901844,5.852766,8.77915,13.16872,19.75309,29.62963,44.44444,66.66667,100)

assay_order <- c("NVS_NR_bER", "NVS_NR_hER", "NVS_NR_mERa", "OT_ER_ERaERa_0480",
                 "OT_ER_ERaERa_1440", "OT_ER_ERaERb_0480", "OT_ER_ERaERb_1440",
                 "OT_ER_ERbERb_0480", "OT_ER_ERbERb_1440", "OT_ERa_EREGFP_0120",
                 "OT_ERa_EREGFP_0480", "ATG_ERa_TRANS_up", "ATG_ERE_CIS_up",
                 "TOX21_ERa_BLA_Agonist_ratio", "TOX21_ERa_LUC_BG1_Agonist",
                 "ACEA_T47D_80hr_Positive", "TOX21_ERa_BLA_Antagonist_ratio",
                 "TOX21_ERa_LUC_BG1_Antagonist")

pseudo_receptor_columns <- c("AUC.R3", "AUC.R4", "AUC.R5", "AUC.R6", "AUC.R7", "AUC.R8",
                             "AUC.R9", "AUC.A1", "AUC.A2", "AUC.A3", "AUC.A4", "AUC.A5", "AUC.A6",
                             "AUC.A7", "AUC.A8", "AUC.A9", "AUC.A10", "AUC.A11", "AUC.A12",
                             "AUC.A13", "AUC.A14", "AUC.A15", "AUC.A17", "AUC.A18")

auc_names <- c("AUC.Agonist", "AUC.Antagonist",
               pseudo_receptor_columns, "code")
#modl_ga column names
modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")
