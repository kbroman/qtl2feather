% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rbind_feather_genoprob.R
\name{rbind.feather_genoprob}
\alias{rbind.feather_genoprob}
\title{Join genotype probabilities for different individuals}
\usage{
\method{rbind}{feather_genoprob}(..., fbase, fdir = NULL)
}
\arguments{
\item{...}{Genotype probability objects as produced by
\code{\link{feather_genoprob}}. Must have the same set of markers and
genotypes.}

\item{fbase}{Base of fileame for feather database. 
Needed if objects have different feather databases.}

\item{fdir}{Directory for feather database.}
}
\value{
A single genotype probability object.
}
\description{
Join multiple genotype probability objects, as produced by
\code{\link{feather_genoprob}} for different individuals.
}
\examples{
library(qtl2)
grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
probsA <- calc_genoprob(grav2[1:5,], map, error_prob=0.002)
probsB <- calc_genoprob(grav2[6:12,], map, error_prob=0.002)
dir <- tempdir()
fprobsA <- feather_genoprob(probsA, "exampleAr", dir)
fprobsB <- feather_genoprob(probsB, "exampleBr", dir)
fprobs <- rbind(fprobsA, fprobsB, fbase = "exampleABr")

}
