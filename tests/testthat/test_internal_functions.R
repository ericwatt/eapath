library(eapath)
library(data.table)
context("Non exported functions working")

test_that("All functions working", {
  dat_cast <- tcpl_to_model_dat(er_L5_prod_ext_v2, assay_order = assay_order)
  cr.mat <- prepCR(dat_cast, chem = "C500389")
  resmat <- er_model(cr.mat)
  aucval <- AUCcalc(resmat)
  dat_return <- as.data.table(as.list(aucval))
  setnames(dat_return, auc_names[1:26])

  expect_is(dat_cast, "data.table")
  expect_is(cr.mat, "matrix")
  expect_is(resmat, "data.frame")
  expect_is(aucval, "numeric")
})
