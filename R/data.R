#' @title Tuberculosis isolates in France
#'
#' @description
#' The genotypes of 1,641 tuberculosis isolates from France, typed
#' using 15-loci minisatellite markers (mycobacterial interspersed repeated units, MIRU),
#' along with exemplary metadata regarding pulmonary localization of disease
#' and sputum smear positivity for acid-fast bacilli.
#' @format
#'
#' A list with following elements:
#'
#' \itemize{
#' \item{}{\code{miru} is a 1,641 x 15 matrix of MIRU repeat counts with individuals in rows and markers in columns}
#' \item{}{\code{meta}} is dataframe with two logical columns: \code{afb} denotes presence of acid-fast bacilli in sputum smear
#' and \code{lung} denotes pulmonary infection (TB-positive culture or molecular test from a respiratory sample).
#' }
#'
#' @usage data(tb)
"tb"
