# feather_genoprob_restore
#' Restore feather_genoprob object to original dimensions.
#'
#' Any \code{\link{feather_genoprob}} object has embedded its original data and dimensions.
#' This resets elements \code{ind}, \code{chr} and \code{mar} to the full set.
#'
#' @param object Object of class \code{\link{feather_genoprob}}.
#' 
#' @return Element of class \code{\link{feather_genoprob}}.
#'
#' @details
#' Object is unclassed and elements \code{ind}, \code{chr} and \code{mar} are changed before
#' reseting attributes as \code{\link{feather_genoprob}} object.
#' See \code{\link{feather_genoprob}} return description for details.
#' 
#' @export
#' @keywords utilities
#'
#' @examples
#' library(qtl2geno)
#' grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2geno"))
#' map <- insert_pseudomarkers(grav2$gmap, step=1)
#' probs <- calc_genoprob(grav2, map, error_prob=0.002)
#' fprobs <- feather_genoprob(probs, "my.feather")
#' dim(fprobs)
#' fprobs2 <- subset(fprobs, chr=1:2)
#' dim(fprobs2)
#' fprobs5 <- feather_genoprob_restore(fprobs2)
#' dim(fprobs5)
#' 
feather_genoprob_restore <- function(object) {
  if(!inherits(object, "feather_genoprob"))
    stop("object must inherit class feather_genoprob")
  
  attrs <- attributes(object)
  result <- unclass(object)
  
  result$chr <- names(result$dimnames)
  result$ind <- result$dimnames[[1]][[1]]
  result$mar <- unlist(lapply(result$dimnames, function(x) x[[3]]))
  
  # Set up attributes.
  ignore <- match(c("names","class"), names(attrs))
  for(a in names(attrs)[-ignore])
    attr(result, a) <- attrs[[a]]
  
  class(result) <- attrs$class
  
  result
}