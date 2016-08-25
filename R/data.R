#' ER ToxCast Data
#'
#' A dataset containing ToxCast model parameters, hit calls, assays, and
#' chemical info to generate ER Model AUC values. Data is pulled from the
#' October 2015 public release (prod_external_invitrodb_v2), and subset down to
#' the minimum needed to run the model.
#'
#' @format A data.table with 60330 rows and 9 columns
#'
"er_L5_prod_ext_v2"

#' AR ToxCast Data
#'
#' A dataset containing ToxCast model parameters, hit calls, assays, and
#' chemical info to generate AR Model AUC values. Data is pulled from the
#' internal release (invitrodb), and subset down to
#' the minimum needed to run the model.
#'
#' @format A data.table with 42734 rows and 9 columns
#'
"ar_L5_invitrodb"

#' AR Viability ToxCast Data
#'
#' A dataset containing ToxCast model parameters, hit calls, assays, and
#' chemical info to generate ER Model AUC values. Data is pulled from the
#' internal release (invitrodb), and subset down to
#' the minimum needed to run the model. Viability data for TOX21 Antagonist
#' assays used to filter activity calls.
#'
#' @format A data.table with 16179 rows and 9 columns
#'
"ar_L5_invitrodb_viability"
