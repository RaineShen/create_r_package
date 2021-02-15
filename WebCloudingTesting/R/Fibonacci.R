#' Fibonacci
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param infile Path to the input file
#' @return A matrix of the infile
#' @export

Fibonacci <- function(n){
  a <- 0
  b <- 1
  for (i in 1:n){
    temp <- b
    b <- a
    a <- a + temp
  }
  return(a)
}

