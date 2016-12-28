<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/ericwatt/eapath.svg?branch=master)](https://travis-ci.org/ericwatt/eapath) [![Coverage Status](https://img.shields.io/codecov/c/github/ericwatt/eapath/master.svg)](https://codecov.io/github/ericwatt/eapath?branch=master) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/eapath)](https://cran.r-project.org/package=eapath)

eapath: Computational Models for Estrogen and Androgen Receptor Activity
------------------------------------------------------------------------

### Installation

eapath contains both data and code to calculate estrogen and androgen AUC values.

It can be installed using devtools. After installing devtools, run the following to install the newest development version of eapath.

    # install.packages("devtools")
    devtools::install_github("ericwatt/eapath")

To install all of the suggested packages as well, which are used to develop the package and run some of the examples, include the option `dependencies = TRUE`.

    devtools::install_github("ericwatt/eapath", dependencies = TRUE)

``` r
library(eapath)
library(data.table)
```

Estrogen receptor calculation
-----------------------------

The package includes all ToxCast data for ER assays. This can be accessed in `er_L5_prod_ext_v2`. An example of this data for one chemical:

<table>
<colgroup>
<col width="22%" />
<col width="6%" />
<col width="6%" />
<col width="26%" />
<col width="5%" />
<col width="5%" />
<col width="8%" />
<col width="8%" />
<col width="8%" />
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
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">9056516</td>
<td align="center">ACEA_T47D_80hr_Positive</td>
<td align="center">2</td>
<td align="center">1</td>
<td align="center">-1.867</td>
<td align="center">8</td>
<td align="center">27.59</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8174202</td>
<td align="center">ATG_ERE_CIS_up</td>
<td align="center">75</td>
<td align="center">1</td>
<td align="center">0.8566</td>
<td align="center">1.514</td>
<td align="center">2.094</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8509521</td>
<td align="center">ATG_ERa_TRANS_up</td>
<td align="center">117</td>
<td align="center">1</td>
<td align="center">0.9017</td>
<td align="center">1.83</td>
<td align="center">2.276</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">7685532</td>
<td align="center">NVS_NR_bER</td>
<td align="center">708</td>
<td align="center">1</td>
<td align="center">1.15</td>
<td align="center">0.7664</td>
<td align="center">81.82</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">7688098</td>
<td align="center">NVS_NR_hER</td>
<td align="center">714</td>
<td align="center">1</td>
<td align="center">-0.2094</td>
<td align="center">1.449</td>
<td align="center">79.46</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">7693250</td>
<td align="center">NVS_NR_mERa</td>
<td align="center">725</td>
<td align="center">1</td>
<td align="center">0.2719</td>
<td align="center">1.571</td>
<td align="center">86.51</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8772706</td>
<td align="center">OT_ER_ERaERa_0480</td>
<td align="center">742</td>
<td align="center">1</td>
<td align="center">0.9288</td>
<td align="center">1.725</td>
<td align="center">198.8</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8774332</td>
<td align="center">OT_ER_ERaERa_1440</td>
<td align="center">743</td>
<td align="center">1</td>
<td align="center">0.8362</td>
<td align="center">4.191</td>
<td align="center">69.81</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8776446</td>
<td align="center">OT_ER_ERaERb_0480</td>
<td align="center">744</td>
<td align="center">1</td>
<td align="center">0.4789</td>
<td align="center">3.256</td>
<td align="center">168.6</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8778155</td>
<td align="center">OT_ER_ERaERb_1440</td>
<td align="center">745</td>
<td align="center">1</td>
<td align="center">1.385</td>
<td align="center">1.812</td>
<td align="center">834.9</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8780054</td>
<td align="center">OT_ER_ERbERb_0480</td>
<td align="center">746</td>
<td align="center">1</td>
<td align="center">0.5387</td>
<td align="center">7.999</td>
<td align="center">108.8</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8782066</td>
<td align="center">OT_ER_ERbERb_1440</td>
<td align="center">747</td>
<td align="center">1</td>
<td align="center">0.8208</td>
<td align="center">2.491</td>
<td align="center">36.02</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8788070</td>
<td align="center">OT_ERa_EREGFP_0120</td>
<td align="center">750</td>
<td align="center">1</td>
<td align="center">0.1681</td>
<td align="center">4.769</td>
<td align="center">81.79</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">8790123</td>
<td align="center">OT_ERa_EREGFP_0480</td>
<td align="center">751</td>
<td align="center">1</td>
<td align="center">0.7216</td>
<td align="center">4.88</td>
<td align="center">81.71</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">1265922</td>
<td align="center">TOX21_ERa_BLA_Agonist_ratio</td>
<td align="center">785</td>
<td align="center">1</td>
<td align="center">1.786</td>
<td align="center">3.506</td>
<td align="center">36.87</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">1276419</td>
<td align="center">TOX21_ERa_BLA_Antagonist_ratio</td>
<td align="center">786</td>
<td align="center">1</td>
<td align="center">1.83</td>
<td align="center">8</td>
<td align="center">108.8</td>
</tr>
<tr class="odd">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">1297413</td>
<td align="center">TOX21_ERa_LUC_BG1_Agonist</td>
<td align="center">788</td>
<td align="center">1</td>
<td align="center">1.246</td>
<td align="center">1.464</td>
<td align="center">44.19</td>
</tr>
<tr class="even">
<td align="center">Nordihydroguaiaretic acid</td>
<td align="center">C500389</td>
<td align="center">1307910</td>
<td align="center">TOX21_ERa_LUC_BG1_Antagonist</td>
<td align="center">789</td>
<td align="center">0</td>
<td align="center">-0.3829</td>
<td align="center">3.082</td>
<td align="center">9.34</td>
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

While the pathway and assay lists are different, the AR model is run by the user in much the same way as the ER model. One additional change is that the assay hitcalls need to be filtered by the viability assays. Both datasets needed to do this are included, `ar_L5_invitrodb` contains the data for the 11 assays to run the model and `ar_L5_invitrodb_viability` has the viability data from `TOX21_AR_BLA_Antagonist_viability` and `TOX21_AR_LUC_MDAKB2_Antagonist2_viability` assays which are used to filter the hit calls for `TOX21_AR_BLA_Antagonist_ratio` and `TOX21_AR_LUC_MDAKB2_Antagonist2` assays.

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
