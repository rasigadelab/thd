#' @name thdfun
#' @title Timescaled haplotypic density
#' @param H matrix of genetic (Hamming) distances between individuals. Must be symmetric.
#' @param t timescale, reflecting the approximate length of time before present considered for density estimation
#' @param m number of markers (e.g. nucleotides) used in genetic distance computation
#' @param mu substitution rate per marker per unit of time
#' @param scale optional rescaling of output. Either \code{density} (default), \code{size}, \code{relative} or \code{time}. See details for specific use cases.
#' @param q quantile (see details)
#' @description
#' Compute timescaled haplotypic densities (THDs) for a series of individuals based on genetic distances.
#'
#' `thd` is the main function, taking a distance matrix as input. The helper function `thd.bandwidth` computes the kernel density bandwidth (or smoothing parameter)
#' for a given timescale, no. of markers and substitution rate.
#'
#' @details
#'
#' The \code{scale} parameter provides scaling options detailed below.
#' \itemize{
#' \item{\code{"density"}: }
#' {(default) the THD output is a normalized density, that typically decreases with the no. of markers.}
#' \item{\code{"size"}: }
#' {the density is multiplied by the number of markers \code{m}. This scaled output is approximately invariant wrt to \code{m}, allowing
#' to compare outputs between datasets with various resolutions (e.g. minisatellites with small \code{m} vs whole genomes with large \code{m}).}
#' \item{\code{"relative"}: }
#' {the output is expressed relative to the theoretical maximum value, obtained for a set of completely identical isolates (that is, \code{H} is a matrix of zeroes).
#' This scaling can be useful when the individuals are highly similar. The output is between 0 and 1.}
#' \item{\code{"time"}: }
#' {the output is expressed relative to the theoretical value obtained if all individuals has diverged exactly at rate \code{mu} for a period of length \code{t} (that is,
#' \code{H} is a matrix where all off-diagonal entries equal \code{iam.distance(t, m, mu)}). This scaling allows to compare analyses with different timescales.}
#' }
#'
#'
#' The optional \code{quantile} parameter controls the relationship between the provided timescale \code{t} and the kernel bandwidth.
#' By default, the bandwidth is chosen so that individuals whose estimated time of divergence is at most \code{t} account for 50% of the density (default \code{q = 0.5}).
#' Setting \code{q = 0.1} means that a divergence less than \code{t} now accounts for 10% of the density, which is approximately equivalent to using a much longer timescale.
#' The parameter is provided for the sake of completeness, change it only if you know what you're doing.
#'
#' #' Additional requirements:
#'\itemize{
#'\item{}{The unit of time must be identical for \code{t} and \code{mu}.}
#'\item{}{\code{H} must be symmetric with zeroes on the diagonal}
#'}
#'
#' @return Vector of THD values, named after column names of \code{H} if present.
#' @example examples/example.R
NULL

iam.distance <- function(t, m, mu) m*(1 - exp(-2 * mu * t))

#' @rdname thdfun
#' @order 3
#' @export
thd.bandwidth <- function(t, m, mu, q = 0.5) {
  if(t == 0) return(NA)
  # IAM inverse relation between TMRCA t and expected Hamming distance h
  h <- iam.distance(t, m, mu)
  # Objective function
  objfun <- function(b) ( q*(1-b^m) - (1 - b^h) )^2
  # Minimize objective function in (0, 1)
  opt <- optimise(objfun, c(1e-9, 1 - 1e-9))
  return(opt$minimum)
}

#' @rdname thdfun
#' @order 1
#' @export
thd <- function(H, t, m, mu, scale = "density", q = 0.5) {
  # Compute THD bandwidth
  b <- thd.bandwidth(t, m, mu, q)
  # Check symmetry
  stopifnot(all(H == t(H)))
  # Check zero diagonal
  stopifnot(all(diag(H) == 0))
  # Let B <- b^h
  B <- b^H
  # Take columns sums, subtract 1 (= b^0) to ignore diagonal
  Bsums <- colSums(B) - 1
  # Normalization constant
  nc <- (1 - b) / ( (1 - b^(m+1)) * (nrow(H) - 1) )
  # Rescale if required
  return(switch(scale,
                density = {
                  # Normalized density
                  Bsums * nc
                },
                size = {
                  # Rescale by no. of markers
                  Bsums * nc * m
                },
                relative = {
                  # Relative to completely homogeneous population
                  Bsums / (nrow(H) - 1)
                },
                time = {
                  # Relative to expected distance since timescale
                  Bsums / ( (nrow(H) - 1) * b^iam.distance(t, m, mu))
                }
  ))
}
