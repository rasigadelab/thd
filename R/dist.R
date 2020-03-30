#' @title Hamming distance matrix
#' @param x matrix with individuals in rows and markers in columns.
#' @description Compute the pairwaise Hamming distances (no. of differences) between individuals.
#' Accepts any storage class with a defined unequality operator \code{!=} including integer (e.g., minisatellite repeat counts) or character (nucleotides).
#' \code{NA}s not allowed.
#' @return A square symmetric matrix of Hamming distances.
#' @export
hamming <- function(x) {
  stopifnot(all(!is.na(x)))
  p <- ncol(x)
  n <- nrow(x)
  xt <- t(x)
  H <- diag(rep(0, n))
  colnames(H) <- rownames(H) <- rownames(x)
  for(i in 1:(n-1)) {
    xi <- xt[,i]
    for(j in (i+1):n) {
      H[i,j] <- sum(xi != xt[, j])
    }
  }
  H <- H + t(H)
  return(H)
}
