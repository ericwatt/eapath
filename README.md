<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ericwatt/eapath.svg?branch=master)](https://travis-ci.org/ericwatt/eapath) [![Coverage Status](https://img.shields.io/codecov/c/github/ericwatt/eapath/master.svg)](https://codecov.io/github/ericwatt/eapath?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/eapath)](https://cran.r-project.org/package=eapath)

eapath: Computational Models for Estrogen and Androgen Receptor Activity
------------------------------------------------------------------------

eapath contains both data and code to calculate estrogen and androgen AUC values. It can be installed using devtools:

    devtools::install_github("ericwatt/eapath")

Estrogen receptor calculation
-----------------------------

The package includes all ToxCast data for ER assays. This can be accessed in `er_L5_prod_ext_v2`.

``` r
pander(head(er_L5_prod_ext_v2), split.table = Inf)
```

<table>
<colgroup>
<col width="18%" />
<col width="9%" />
<col width="7%" />
<col width="22%" />
<col width="6%" />
<col width="6%" />
<col width="9%" />
<col width="9%" />
<col width="9%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">chnm</th>
<th align="center">code</th>
<th align="center">m4id</th>
<th align="center">aenm</th>
<th align="center">aeid</th>
<th align="center">hitc</th>
<th align="center">modl_ga</th>
<th align="center">modl_gw</th>
<th align="center">modl_tp</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">NA</td>
<td align="center">NA</td>
<td align="center">9056353</td>
<td align="center">ACEA_T47D_80hr_Positive</td>
<td align="center">2</td>
<td align="center">1</td>
<td align="center">-5.195</td>
<td align="center">1.288</td>
<td align="center">96.34</td>
</tr>
<tr class="even">
<td align="center">Acetamide</td>
<td align="center">C60355</td>
<td align="center">9056688</td>
<td align="center">ACEA_T47D_80hr_Positive</td>
<td align="center">2</td>
<td align="center">0</td>
<td align="center">NA</td>
<td align="center">NA</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">Acetaminophen</td>
<td align="center">C103902</td>
<td align="center">9056037</td>
<td align="center">ACEA_T47D_80hr_Positive</td>
<td align="center">2</td>
<td align="center">0</td>
<td align="center">NA</td>
<td align="center">NA</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">Dehydroacetic acid</td>
<td align="center">C520456</td>
<td align="center">9056593</td>
<td align="center">ACEA_T47D_80hr_Positive</td>
<td align="center">2</td>
<td align="center">0</td>
<td align="center">1.918</td>
<td align="center">7.862</td>
<td align="center">29.27</td>
</tr>
<tr class="odd">
<td align="center">Acifluorfen</td>
<td align="center">C50594666</td>
<td align="center">9056340</td>
<td align="center">ACEA_T47D_80hr_Positive</td>
<td align="center">2</td>
<td align="center">0</td>
<td align="center">NA</td>
<td align="center">NA</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">Acrylamide</td>
<td align="center">C79061</td>
<td align="center">9057866</td>
<td align="center">ACEA_T47D_80hr_Positive</td>
<td align="center">2</td>
<td align="center">0</td>
<td align="center">NA</td>
<td align="center">NA</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

The first step is to restructure the data using function `tcpl_to_model_dat`.

``` r
dat_cast <- tcpl_to_model_dat(er_L5_prod_ext_v2, pathway = "ER")
```

This wide format table can now be passed to the function `er_model_light`. The example below performs the calculation for 4 chemicals.

``` r
  codes <- c("C500389", "C100005", "C57636", "C10161338")
  auc_results <- lapply(codes,
                        er_model_light,
                        dat = dat_cast,
                        pathway = "ER")

  dat_auc <- rbindlist(auc_results)
```

Then the columns are named

``` r
  pseudo_receptor_columns <- c("AUC.R3", "AUC.R4", "AUC.R5", "AUC.R6", "AUC.R7", "AUC.R8",
                               "AUC.R9", "AUC.A1", "AUC.A2", "AUC.A3", "AUC.A4", "AUC.A5", "AUC.A6",
                               "AUC.A7", "AUC.A8", "AUC.A9", "AUC.A10", "AUC.A11", "AUC.A12",
                               "AUC.A13", "AUC.A14", "AUC.A15", "AUC.A17", "AUC.A18")

  auc_names <- c("AUC.Agonist", "AUC.Antagonist",
                 pseudo_receptor_columns, "code")

  setnames(dat_auc, auc_names)
```

``` r
pander(dat_auc[, .(code, AUC.Agonist, AUC.Antagonist)])
```

<table style="width:56%;">
<colgroup>
<col width="13%" />
<col width="19%" />
<col width="22%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">code</th>
<th align="center">AUC.Agonist</th>
<th align="center">AUC.Antagonist</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">C500389</td>
<td align="center">0.261</td>
<td align="center">0</td>
</tr>
<tr class="even">
<td align="center">C100005</td>
<td align="center">0</td>
<td align="center">0</td>
</tr>
<tr class="odd">
<td align="center">C57636</td>
<td align="center">0.9983</td>
<td align="center">0.003788</td>
</tr>
<tr class="even">
<td align="center">C10161338</td>
<td align="center">0.5297</td>
<td align="center">0</td>
</tr>
</tbody>
</table>

Androgen receptor calculation
-----------------------------

While the pathway and assay lists are different, the AR model is run by the user in much the same way as the ER model. One additional change is that the assay hitcalls need to be filtered by the viability assays. Both datasets needed to do this are included, `ar_L5_invitrodb` contains the data for the 11 assays to run the model and `ar_L5_invitrodb_viability` has the viability data from `TOX21_AR_BLA_Antagonist_viability` and `TOX21_AR_LUC_MDAKB2_Antagonist2_viability` assays which are used to filter the hit calls for T`OX21_AR_BLA_Antagonist_ratio` and `TOX21_AR_LUC_MDAKB2_Antagonist2` assays.

``` r
  dat <- via_filter(ar_L5_invitrodb, ar_L5_invitrodb_viability)
  dat_cast <- tcpl_to_model_dat(dat, pathway = "AR")
  dat_auc <- er_model_light(dat = dat_cast, chem = "C68962", pathway = "AR")

  pseudo_receptor_columns <- c("AUC.R3", "AUC.R4", "AUC.R5", "AUC.R6",
                               "AUC.R7", "AUC.A1", "AUC.A2", "AUC.A3",
                               "AUC.A4", "AUC.A5", "AUC.A7", "AUC.A8",
                               "AUC.A9", "AUC.A10", "AUC.A11")

  auc_names <- c("AUC.Agonist", "AUC.Antagonist",
                 pseudo_receptor_columns, "code")

  setnames(dat_auc, auc_names)

  pander(dat_auc[, .(code, AUC.Agonist, AUC.Antagonist)])
```

<table style="width:51%;">
<colgroup>
<col width="9%" />
<col width="19%" />
<col width="22%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">code</th>
<th align="center">AUC.Agonist</th>
<th align="center">AUC.Antagonist</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">C68962</td>
<td align="center">0.9414</td>
<td align="center">0</td>
</tr>
</tbody>
</table>
