#' Calculate the least squares solution for one chemical
#'
#' \code{er_model} calculates least squares solution
#'
#' @param adata cr.mat from \code{prepCR}
#' @param do.debug logical to run in debug mode. Default F
#'
#' @importFrom stats optim
#'
#' @return resmat matrix[nconc rows x nreceptor columns]
er_model <- function(dat, code, pathway = "ER", nassay = NULL, conclist = NULL,
                     nreceptor = NULL, aucscale1 = NULL,
                     penalty_method = "THRESHOLD", alpha = NULL, do.debug = F) {

  #Set variables to pathway specific values if they are not provided

  if (pathway == "ER"){
    if (is.null(nassay))    nassay <- 18
    if (is.null(conclist))  conclist <- c(1e-6,2.679636e-06,4.019455e-06,6.029182e-06,9.043773e-06,1.356566e-05,2.034849e-05,3.052273e-05,4.57841e-05,6.867615e-05,0.0001030142,0.0001545213,0.000231782,0.000347673,0.0005215095,0.0007822643,0.001173396,0.001760095,0.002640142,0.003960213,0.005940319,0.008910479,0.01336572,0.02004858,0.03007287,0.0451093,0.06766395,0.1014959,0.1522439,0.2283658,0.3425487,0.5138231,0.7707347,1.156102,1.734153,2.601229,3.901844,5.852766,8.77915,13.16872,19.75309,29.62963,44.44444,66.66667,100)
    if (is.null(nreceptor)) nreceptor <- 26
    if (is.null(aucscale1)) aucscale1 <- 3.8
    if (is.null(alpha))     alpha <- 1
    assay_order <- c("NVS_NR_bER", "NVS_NR_hER", "NVS_NR_mERa", "OT_ER_ERaERa_0480",
                     "OT_ER_ERaERa_1440", "OT_ER_ERaERb_0480", "OT_ER_ERaERb_1440",
                     "OT_ER_ERbERb_0480", "OT_ER_ERbERb_1440", "OT_ERa_EREGFP_0120",
                     "OT_ERa_EREGFP_0480", "ATG_ERa_TRANS_up", "ATG_ERE_CIS_up",
                     "TOX21_ERa_BLA_Agonist_ratio", "TOX21_ERa_LUC_BG1_Agonist",
                     "ACEA_T47D_80hr_Positive", "TOX21_ERa_BLA_Antagonist_ratio",
                     "TOX21_ERa_LUC_BG1_Antagonist")
    modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
    modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
    modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")
  } else if (pathway == "AR"){
    if (is.null(nassay))    nassay <- 11
    if (is.null(conclist))  conclist <- c(0.0122,0.0244,0.0488,0.0977,0.195,0.391,0.781,1.56,3.125,6.25,12.5,25,50,100)
    if (is.null(nreceptor)) nreceptor <- 17
    if (is.null(aucscale1)) aucscale1 <- 4.173554
    if (is.null(alpha))     alpha <- 0.05
    assay_order <- c("NVS_NR_hAR", "NVS_NR_cAR", "NVS_NR_rAR", "OT_AR_ARSRC1_0480",
                     "OT_AR_ARSRC1_0960", "OT_AR_ARELUC_AG_1440", "ATG_AR_TRANS_up",
                     "TOX21_AR_BLA_Agonist_ratio", "TOX21_AR_LUC_MDAKB2_Agonist",
                     "TOX21_AR_BLA_Antagonist_ratio", "TOX21_AR_LUC_MDAKB2_Antagonist2")
    modl_ga_cols <- paste("modl_ga_", assay_order, sep = "")
    modl_tp_cols <- paste("modl_tp_", assay_order, sep = "")
    modl_gw_cols <- paste("modl_gw_", assay_order, sep = "")
  } else {
    stop("Pathway ", pathway, " is not recognized",
         call. = FALSE)
  }

  cr.mat <- prepCR(dat = dat, chem = code, conclist = conclist, nassay = nassay,
                   modl_ga_cols = modl_ga_cols, modl_tp_cols = modl_tp_cols, modl_gw_cols = modl_gw_cols)

  nconc <- length(conclist)
  adata <- as.data.frame(t(cr.mat))
  adata <- cbind(adata, tmat_va(pathway = pathway, nassay = nassay, nreceptor = nreceptor))
  conc.names <- c()
  for(i in 1:nconc) conc.names <- c(conc.names,paste("C",i,sep=""))
  t.names <- c()
  for(i in 1:nreceptor) t.names <- c(t.names,paste("T",i,sep=""))
  names(adata) <- c(conc.names,t.names)
  nuse <- nconc

  temp <- adata[1,1:nconc]
  a1 <- as.numeric(temp[1:nuse])
  xlist <- conclist
  anames <- c()
  for(i in 1:nassay) anames <- c(anames,paste("A",i,sep=""))
  counter <- 1

  # calculate the model

  resmat <- as.data.frame(matrix(nrow=nconc,ncol=nreceptor))
  allrnames <- c()
  for(i in 1:nreceptor) allrnames <- c(allrnames,paste("R",i,sep=""))
  names(resmat) <- allrnames
  resmat[] <- 0
  start <- vector(mode="numeric",length=nreceptor)
  lwr   <- vector(mode="numeric",length=nreceptor)
  upr   <- vector(mode="numeric",length=nreceptor)
  start[] <- 0
  lwr[] <- 0
  upr[] <- 1
  for(i in 1:nconc) {
    concname <- paste("C",i,sep="")
    A <- adata[,c(concname,t.names)]
    if(i>1) start <- res$par
    res <- optim(par            = start,
                 fn             = afr_va,
                 A              = A,
                 nassay         = nassay,
                 nreceptor      = nreceptor,
                 pathway        = pathway,
                 alpha          = alpha,
                 penalty_method = penalty_method,
                 method         = "L-BFGS-B",
                 lower          = lwr,
                 upper          = upr,
                 control        = list(maxit=2000))
    for(j in 1:nreceptor) resmat[i,j] <- res$par[j]*aucscale1
    if(res$convergence!=0 || do.debug) cat(i,"Convergence: ",res$convergence," Calls: ",res$counts," residual: ",res$value," : ",res$message,"\n")
    if(do.debug) print(res$par)
  }
  return(resmat)
}
