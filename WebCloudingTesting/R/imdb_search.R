#' search
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param A id
#' @return A dataframe
#' @export

imdb_search <- function(imdb_id){
  
  id_search_url <- "http://www.omdbapi.com/?i="
  apikey <- 'apikey=45abab5f'
  
  id_url <- paste0(id_search_url, paste(imdb_id, apikey, sep = '&'))
  movie <- httr::GET(url = id_url)
  movie_httr <- httr::content(movie, as = "text")
  movie_json <- fromJSON(movie_httr)
  if (movie_json$Response == 'True'){
    return(movie_json)
  } else {
    print(movie_json$Error)
    return (NULL)
  }   
}
