% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/thd.R
\name{thd}
\alias{thd}
\alias{thd.bandwidth}
\alias{thdfun}
\title{Timescaled haplotypic density}
\usage{
thd(H, t, m, mu, scale = "density", q = 0.5)

thd.bandwidth(t, m, mu, q = 0.5)
}
\arguments{
\item{H}{matrix of genetic (Hamming) distances between individuals. Must be symmetric.}

\item{t}{timescale, reflecting the approximate length of time before present considered for density estimation}

\item{m}{number of markers (e.g. nucleotides) used in genetic distance computation}

\item{mu}{substitution rate per marker per unit of time}

\item{scale}{optional rescaling of output. Either \code{density} (default), \code{size}, \code{relative} or \code{time}. See details for specific use cases.}

\item{q}{quantile (see details)}
}
\value{
Vector of THD values, named after column names of \code{H} if present.
}
\description{
Compute timescaled haplotypic densities (THDs) for a series of individuals based on genetic distances.

`thd` is the main function, taking a distance matrix as input. The helper function `thd.bandwidth` computes the kernel density bandwidth (or smoothing parameter)
for a given timescale, no. of markers and substitution rate.
}
\details{
The \code{scale} parameter provides scaling options detailed below.
\itemize{
\item{\code{"density"}: }
{(default) the THD output is a normalized density, that typically decreases with the no. of markers.}
\item{\code{"size"}: }
{the density is multiplied by the number of markers \code{m}. This scaled output is approximately invariant wrt to \code{m}, allowing
to compare outputs between datasets with various resolutions (e.g. minisatellites with small \code{m} vs whole genomes with large \code{m}).}
\item{\code{"relative"}: }
{the output is expressed relative to the theoretical maximum value, obtained for a set of completely identical isolates (that is, \code{H} is a matrix of zeroes).
This scaling can be useful when the individuals are highly similar. The output is between 0 and 1.}
\item{\code{"time"}: }
{the output is expressed relative to the theoretical value obtained if all individuals has diverged exactly at rate \code{mu} for a period of length \code{t} (that is,
\code{H} is a matrix where all off-diagonal entries equal \code{iam.distance(t, m, mu)}). This scaling allows to compare analyses with different timescales.}
}


The optional \code{quantile} parameter controls the relationship between the provided timescale \code{t} and the kernel bandwidth.
By default, the bandwidth is chosen so that individuals whose estimated time of divergence is at most \code{t} account for 50% of the density (default \code{q = 0.5}).
Setting \code{q = 0.1} means that a divergence less than \code{t} now accounts for 10% of the density, which is approximately equivalent to using a much longer timescale.
The parameter is provided for the sake of completeness, change it only if you know what you're doing.

#' Additional requirements:
\itemize{
\item{}{The unit of time must be identical for \code{t} and \code{mu}.}
\item{}{\code{H} must be symmetric with zeroes on the diagonal}
}
}
\examples{
# Simulate distance matrix
H <- matrix(c(
  00, 00, 00, 00, 00, 00,
  01, 00, 00, 00, 00, 00,
  03, 01, 00, 00, 00, 00,
  21, 18, 28, 00, 00, 00,
  23, 25, 31, 07, 00, 00,
  19, 27, 23, 09, 11, 00
), ncol = 6, byrow = TRUE)

# Make matrix symmetric
H <- H + t(H)
colnames(H) <- LETTERS[1:ncol(H)]

# Dendrogram
hc <- hclust(as.dist(H))

# Select THD parameters
m   <- 64
mu  <- 0.001
t50 <- 20

# Compute THD values
x <- thd(H, t50, m, mu, scale = "time")

# Visualize dendrogram and THD
par(mfrow = c(2, 1))
par(mar = c(2, 10, 2, 10))
plot(hc, hang = -1, xlab = "", yaxt = "n", ylab = "")
par(mar = c(2, 4, 2, 4))
barplot(x[hc$order], xlim = c())
}
