#' @title Principal component-based correction for population structure
#' @description
#' Generate a matrix of principal components (PCs) significantly associated with THD.
#' Include these PCs in multivariate models to correct for population structure.
#' @param x vector of THD values
#' @param H genetic distance matrix used to generate \code{x}
#' @param m maximum number of PCs to be considered. Typically, the no. of markers used to generate \code{H}.
#' @param method P-value adjustment method passed to \code{p.adjust}. Default = false discovery rate (FDR).
#' @param alpha significance threshold to retain a given PC.
#' @return Matrix with \code{length(x)} rows and one column per PC significantly associated with \code{x}.
#' If no PC is found, a 0-column matrix is returned.
#' @export
thd.adjust <- function(x, H, m, method = "fdr", alpha = 0.05) {
  # Compute PCs
  pcs <- cmdscale(H, m)
  colnames(pcs) <- paste("PC", 1:m, sep = "")
  # Extract coefficient p-values for association with THD
  pvals <- coef(summary(lm(x ~ pcs)))[-1, 4]
  # Adjust p-values
  pvals <- p.adjust(pvals, method)
  # Select significant PCs
  return(pcs[, pvals < alpha])
}
