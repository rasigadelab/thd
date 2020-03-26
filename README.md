R Markdown
----------

This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

    summary(cars)

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

Including Plots
---------------

You can also embed plots, for example:

![](README_files/figure-markdown_strict/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.

Time-scaled haplotypic density (THD) implementation for R.
==========================================================

THD estimates epidemic success from pathogen genetic data.

For applications, see:

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
