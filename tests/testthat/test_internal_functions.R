library(eapath)
library(data.table)
context("Non exported functions working")

test_that("All functions working", {
  assay_order <- c("NVS_NR_bER", "NVS_NR_hER", "NVS_NR_mERa", "OT_ER_ERaERa_0480",
    "OT_ER_ERaERa_1440", "OT_ER_ERaERb_0480", "OT_ER_ERaERb_1440", "OT_ER_ERbERb_0480",
    "OT_ER_ERbERb_1440", "OT_ERa_EREGFP_0120", "OT_ERa_EREGFP_0480", "ATG_ERa_TRANS_up",
    "ATG_ERE_CIS_up", "TOX21_ERa_BLA_Agonist_ratio", "TOX21_ERa_LUC_BG1_Agonist",
    "ACEA_T47D_80hr_Positive", "TOX21_ERa_BLA_Antagonist_ratio", "TOX21_ERa_LUC_BG1_Antagonist")

  conclist <- c(1e-06, 2.679636e-06, 4.019455e-06, 6.029182e-06, 9.043773e-06,
    1.356566e-05, 2.034849e-05, 3.052273e-05, 4.57841e-05, 6.867615e-05, 0.0001030142,
    0.0001545213, 0.000231782, 0.000347673, 0.0005215095, 0.0007822643, 0.001173396,
    0.001760095, 0.002640142, 0.003960213, 0.005940319, 0.008910479, 0.01336572,
    0.02004858, 0.03007287, 0.0451093, 0.06766395, 0.1014959, 0.1522439, 0.2283658,
    0.3425487, 0.5138231, 0.7707347, 1.156102, 1.734153, 2.601229, 3.901844,
    5.852766, 8.77915, 13.16872, 19.75309, 29.62963, 44.44444, 66.66667, 100)

  modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
  modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
  modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")

  dat_cast <- tcpl_to_model_dat(er_L5_prod_ext_v2, assay_order = assay_order, pathway = "ER")
  cr.mat <- prepCR(dat_cast, chem = "C500389", conclist = conclist, nassay = 18,
    modl_ga_cols, modl_tp_cols, modl_gw_cols)
  resmat <- er_model(dat_cast, "C500389", "ER")
  aucval <- AUCcalc(resmat, pathway = "ER")
  # dat_return <- as.data.table(as.list(aucval)) setnames(dat_return, auc_names[1:26])

  expect_is(dat_cast, "data.table")
  expect_is(cr.mat, "matrix")
  expect_is(resmat, 'data.frame')
  expect_is(aucval, 'numeric')
})
