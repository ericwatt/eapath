library(eapath)
library(data.table)
library(parallel)
context("Correct AUC values are calculated")

test_that("Expected AUC values", {
  dat_cast <- tcpl_to_model_dat(er_L5_prod_ext_v2, assay_order = assay_order, pathway = "ER")
  codes <- c("C500389", "C100005", "C57636", "C10161338")
  auc_results <- lapply(codes,
                        er_model_light,
                        dat = dat_cast)

  dat_auc <- rbindlist(auc_results)

  pseudo_receptor_columns <- c("AUC.R3", "AUC.R4", "AUC.R5", "AUC.R6", "AUC.R7", "AUC.R8",
                               "AUC.R9", "AUC.A1", "AUC.A2", "AUC.A3", "AUC.A4", "AUC.A5", "AUC.A6",
                               "AUC.A7", "AUC.A8", "AUC.A9", "AUC.A10", "AUC.A11", "AUC.A12",
                               "AUC.A13", "AUC.A14", "AUC.A15", "AUC.A17", "AUC.A18")

  auc_names <- c("AUC.Agonist", "AUC.Antagonist",
                 pseudo_receptor_columns, "code")

  setnames(dat_auc, auc_names)

  expect_equal(dat_auc[code == "C500389", AUC.Agonist], 0.2609559,
               tolerance = 1e-7, scale = 1)
  expect_equal(dat_auc[code == "C100005", AUC.Agonist], 0,
               tolerance = 1e-7, scale = 1)
  expect_equal(dat_auc[code == "C57636", AUC.Agonist], 0.9982685,
               tolerance = 1e-7, scale = 1)
  expect_equal(dat_auc[code == "C10161338", AUC.Agonist], 0.5296790,
               tolerance = 1e-7, scale = 1)
})
