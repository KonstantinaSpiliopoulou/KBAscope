#' Combines criteria columns.
#'
#' @param x Object of class sf and data frame representing species data.
#' @param KBAcriteria Object of class character to identify the KBAcriteria t
#'                    ested against the data.Takes values "Criterion_A1",
#'                    "Criterion_B1","Criterion_B2","Criterion_B3",
#'                    "Criterion_D1","Criterion_D2" and "Criterion_D3".
#'
#' @return x with one new column for all the KBA criteria
#' @export
#'
#' @examples
#' df<- data.frame(ScientificName=c("A"),Criterion_A1=c("A1a"),Criterion_B1=c("B1")) %>%
#'   cbind(KBAscope::species[1,-3])
#'
#' criteria(df, KBAcriteria=c("Criterion_A1","Criterion_B1"))
#'
#'

criteria<- function(x,KBAcriteria=c("Criterion_A1","Criterion_B1",
                                  "Criterion_B2","Criterion_B3",
                                "Criterion_D1","Criterion_D2","Criterion_D3")){

  Criteria=.=NULL

  x %>% dplyr::mutate(Criteria= base::apply(sf::st_drop_geometry(x[,KBAcriteria]), 1,
    function(x) paste0(x[!x==""], collapse = ",")))
}

