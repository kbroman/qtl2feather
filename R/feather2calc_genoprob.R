# feather_genoprob
#' Store genotype probabilities in feather database
#'
#' Uses package feather to convert R object created in R/qtl2geno for fast access.
#'
#' @param object Object of class \code{\link{feather_genoprob}}.
#'
#' @return An object of class \code{\link[qtlgeno]{calc_genoprob}}.
#'
#' @details
#' The genotype probabilities are extracted from 1-2 feather databases. Each chromosome is extracted in turn.
#' 
#' @export
#' @keywords utilities
#'
#' @examples
#' library(qtl2geno)
#' grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2geno"))
#' probs <- calc_genoprob(grav2, step=1, error_prob=0.002)
#' fprobs <- feather_genoprob(probs, "my.feather")
#' nprobs <- feather2calc_genoprob(fprobs)
#' 
feather2calc_genoprob <- function(object) {
  if(!inherits(object, "feather_genoprob"))
    stop("object must inherit class feather_genoprob")
  
  attrs <- attributes(object)

  chr <- as.list(object)$chr
  result <- vector(mode = "list", length = length(chr))
  for(chri in chr)
    result[[chri]] <- object[[i]]
  
  # Set up attributes.
  ignore <- match(c("names","class"), names(attrs))
  for(a in names(attrs)[-ignore])
    attr(result, a) <- attrs[[a]]
  
  class(result) <- attrs$class[-1]
  
  result
}