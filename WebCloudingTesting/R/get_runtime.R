#' Get_Runtime
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param A text string
#' @return A dataframe
#' @export

get_runtime <- function(search_text, type = ""){
  
  # type can be : movie, series, episode, game
  
  base_search_url <- "http://www.omdbapi.com/?s="
  type = paste0("type=",type)
  apikey <- "apikey=a79b2c95"
  search <- gsub(" ", "+", search_text)
  
  search_url <- paste0(base_search_url, paste(search, type, apikey, sep = '&'))
  result <- httr::GET(url = search_url)
  result_httr <- httr::content(result, as = "text")
  result_json <- fromJSON(result_httr)
  
  title <- NA
  type <- NA
  year <- NA
  runtime <- NA
  
  for (i in 1:length(result_json$Search$imdbID)){
    imdb_id = result_json$Search$imdbID[i]
    imdb_id_details <- imdb_search(imdb_id)
    title[i] <- imdb_id_details$Title
    type[i] <- imdb_id_details$Type
    year[i] <- imdb_id_details$Year
    runtime[i] <- imdb_id_details$Runtime
  }
  
  output = data.frame(title, type, suppressWarnings(as.numeric(year)), suppressWarnings(as.numeric(sapply(strsplit(runtime, " "), "[[", 1))))
  names(output)[1] <- "Title"
  names(output)[2] <- "Type"
  names(output)[3] <- "Year"
  names(output)[4] <- "Runtime (in minutes)"
  return (output)
}
