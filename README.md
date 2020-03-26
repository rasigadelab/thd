Time-scaled haplotypic density (THD) for R.
===========================================

THD is an R package for estimating and comparing the evolutionary
success of individuals in a population based on genetic distances.

The primary application of THD is the quantitative analysis and
identification of factors that influence the epidemic success of
pathogens. The approach assigns a index of epidemic success to each
individual in a population. This index is then typically used as the
response variable in multivariate models including potential predictors
of success. See the publication list below for practical applications.

Installation
------------

Make sure the `devtools` package is installed then run

    devtools::install_github("rasigadelab/thd")

Input and parameters
--------------------

THD analysis requires a matrix of genetic distances and three
user-defined parameters:

-   `t` is the *timescale* parameter that controls the length of time
    considered in analysis. Shorter `t` estimates success in recent
    times while longer `t` considers long-term evolution. The choice
    depends on the evolutionary dynamics of the population. `t`can be as
    small as 1 month for a fast-spreading viral epidemic or several
    hundred years for historical diseases such as tuberculosis.

-   `m` is the number of *markers* used for computing the genetic
    distances. These markers can be anything from minisatellites to
    nucleotides as long as they convey a phylogenetic signal. For
    typical whole genome-based applications, `m` is the effective genome
    size, i.e. the pathogen's genome size minus the size of regions
    excluded from analysis (typically repeated or low-quality regions).

-   `mu` is the *mutation* (or substitution) rate for each marker per
    unit of time. This unit of time must be the same as the one used in
    `t`.

Toy example
-----------

We compute and plot THD values for a synthetic, minimalistic example of
6 individuals.

Load the package and simulate a toy matrix of genetic distances with 3
very similar individuals (A to C) and 3 more distant individuals (D to
E).

    library(thd)
    H <- matrix(c(
      00, 00, 00, 00, 00, 00,
      01, 00, 00, 00, 00, 00,
      03, 01, 00, 00, 00, 00,
      21, 18, 28, 00, 00, 00,
      23, 25, 31, 07, 00, 00,
      19, 27, 23, 09, 11, 00
    ), ncol = 6, byrow = TRUE)

Make the matrix symmetric and assign names to individuals (THD keeps
track of column names in its output).

    H <- H + t(H)
    colnames(H) <- LETTERS[1:ncol(H)]

Choose parameters. Suppose we used 64 markers, each with a substitution
rate of 0.001 per marker per year, and we are interested in a timescale
of 10 years.

    m <- 64
    mu <-  0.001
    t <- 10

Use the `thd` function to compute indices. The `scale = time` option
scales the output relative to the timescale (use `?thd` for details on
scaling options).

    x <- thd(H, t, m, mu, scale = "time")

Visualize the results along with a dendrogram of the isolates.

    hc <- hclust(as.dist(H))
    par(mfrow = c(2, 1))
    par(mar = c(0, 6, 2, 6))
    plot(hc, hang = -1, xlab = "", yaxt = "n", ylab = "", main = "", labels = FALSE)
    par(mar = c(3, 4, 0, 4))
    barplot(x[hc$order], ylim = c(0.5, 0), ylab = "THD")

<img src="README_files/figure-markdown_strict/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

References
----------

Rasigade JP, Barbier M, Dumitrescu O, Pichat C, Carret G, Ronnaux-Baron
AS, Blasquez G, Godin-Benhaim C, Boisset S, Carricajo A, Jacomo V,
Fredenucci I, Pérouse de Montclos M, Flandrois JP, Ader F, Supply P,
Lina G, Wirth T. Strain-specific estimation of epidemic success provides
insights into the transmission dynamics of tuberculosis. Sci Rep. 2017
Mar 28;7:45326. doi: 10.1038/srep45326. PMID: 28349973

Barbier M, Dumitrescu O, Pichat C, Carret G, Ronnaux-Baron AS, Blasquez
G, Godin-Benhaim C, Boisset S, Carricajo A, Jacomo V, Fredenucci I,
Pérouse de Montclos M, Genestet C, Flandrois JP, Ader F, Supply P, Lina
G, Wirth T, Rasigade JP. Changing patterns of human migrations shaped
the global population structure of Mycobacterium tuberculosis in France.
Sci Rep. 2018 Apr 11;8(1):5855. doi: 10.1038/s41598-018-24034-6. PMID:
29643428

Thierry Wirth, Marine Bergot, Jean-Philippe Rasigade, Bruno Pichon,
Maxime Barbier, Patricia Martins-Simoes, Laurent Jacob, Rachel Pike,
Pierre Tissieres, Jean-Charles Picaud, Angela Kearns, Philip Supply,
Marine Butin, Frédéric Laurent, on behalf of the International
Consortium for Staphylococcus capitis neonatal sepsis and the ESGS group
of ESCMID. Niche specialization and spread of a multidrug-resistant
Staphylococcus capitis clone involved in neonatal sepsis. Nat.
Microbiol. 2020 (in press)
