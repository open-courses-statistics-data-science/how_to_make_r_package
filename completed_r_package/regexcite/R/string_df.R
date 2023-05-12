#' Splits a string and creates an ordered dataframe with the result
#'
#' @param x String to be split.
#' @param split Thing to split on.
#'
#' @return A dataframe with two columns: 'order' and 'string'
#' @export
#'
#' @examples
#' x <- "alfa,bravo,charlie,delta"
#' string_df(x, split = ",")
string_df <- function(x, split) {
  x <- strsplit1(x, split)
  dplyr::tibble(
    order=seq_along(x),
    string=x
  )
}
