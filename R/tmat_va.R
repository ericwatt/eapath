#' tmat_va
#'
#' \code{tmat_va} returns the connectivity matrix.
#'
#' @param pathway character length 1. Options are "ER" or "AR".
#' @param nassay integer length 1
#' @param nreceptor integer length 1
#'
#' @return tmat matrix of assay connectivities
tmat_va <- function(pathway, nassay, nreceptor) {
  if(pathway == "ER"){
    tmat <- matrix(0, nrow = nassay, ncol = nreceptor)

    tmat[,1] <-  c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0)
    tmat[,2] <-  c(1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1)
    tmat[,3] <-  c(1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
    tmat[,4] <-  c(0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0)
    tmat[,5] <-  c(0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0)
    tmat[,6] <-  c(0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0)
    tmat[,7] <-  c(0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0)
    tmat[,8] <-  c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0)
    tmat[,9] <-  c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1)

    # NVS
    tmat[,10] <- c(1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
    tmat[,11] <- c(0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
    tmat[,12] <- c(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)

    # OT PC
    tmat[,13] <- c(0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
    tmat[,14] <- c(0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0)
    tmat[,15] <- c(0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0)
    tmat[,16] <- c(0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0)
    tmat[,17] <- c(0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0)
    tmat[,18] <- c(0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0)

    # OT RE
    tmat[,19] <- c(0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0)
    tmat[,20] <- c(0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0)

    # ATG
    tmat[,21] <- c(0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0)
    tmat[,22] <- c(0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0)

    # NCGC Agonist
    tmat[,23] <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0)
    tmat[,24] <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0)

    # NCGC Antagonist
    tmat[,25] <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0)
    tmat[,26] <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1)
  } else if (pathway == "AR"){
    tmat <- matrix(0, nrow = nassay, ncol = nreceptor)

    #Agonist R1
    tmat[,1] <-  c(1,1,1,1,1,1,1,1,1,0,0)

    #Antagonist R2
    tmat[,2] <-  c(1,1,1,1,1,0,0,0,0,1,1)

    #R3 through R7
    tmat[,3] <-  c(1,1,1,0,0,0,0,0,0,0,0)
    tmat[,4] <-  c(0,0,0,1,1,0,0,0,0,0,0)
    tmat[,5] <-  c(0,0,0,0,0,1,0,0,0,0,0)
    tmat[,6] <-  c(0,0,0,0,0,0,1,1,1,0,0)
    tmat[,7] <-  c(0,0,0,0,0,0,0,0,0,1,1)

    #Assay by assay interference
    # NVS
    tmat[,8] <- c(1,0,0,0,0,0,0,0,0,0,0)
    tmat[,9] <- c(0,1,0,0,0,0,0,0,0,0,0)
    tmat[,10] <- c(0,0,1,0,0,0,0,0,0,0,0)

    # OT PC
    tmat[,11] <- c(0,0,0,1,0,0,0,0,0,0,0)
    tmat[,12] <- c(0,0,0,0,1,0,0,0,0,0,0)

    # ATG not needed (same as R5)
    # OT ARE
    tmat[,13] <- c(0,0,0,0,0,0,1,0,0,0,0)

    # NCGC Agonist
    tmat[,14] <- c(0,0,0,0,0,0,0,1,0,0,0)
    tmat[,15] <- c(0,0,0,0,0,0,0,0,1,0,0)

    # NCGC Antagonist
    tmat[,16] <- c(0,0,0,0,0,0,0,0,0,1,0)
    tmat[,17] <- c(0,0,0,0,0,0,0,0,0,0,1)

    # tmat <- tmat[AMASK==1,]
    # rmask <- colSums(tmat)
    # rmask[rmask>0] <- 1
    # tmat <- tmat[,rmask==1]
    # TMAT <<- tmat
    # RMASK <<- rmask
  } else {
    stop("Pathway ", pathway, " is not recognized",
         call. = FALSE)
  }

  return(tmat)
}
