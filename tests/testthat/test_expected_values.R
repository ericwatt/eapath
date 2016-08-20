library(eapath)
library(data.table)
library(parallel)
context("Correct AUC values are calculated")

test_that("Expected AUC values", {
    dat_cast <- tcpl_to_model_dat(er_L5_prod_ext_v2, assay_order = assay_order)
    codes <- c("C500389", "C100005", "C57636", "C10161338")
    auc_results <- lapply(codes,
                            er_model_light,
                            dat = dat_cast)

    dat_auc <- rbindlist(auc_results)
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
