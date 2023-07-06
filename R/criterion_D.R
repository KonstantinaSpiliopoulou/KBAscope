#' ests against KBA criteria for D: Biological Processes
#'
#' @param x Object of class sf and data frame with all relevant information to
#'          apply KBA criterion A.
#'
#' @return x with three new columns Criterion_D1, Criterion_D2 and Criterion_D3.
#' @export
#'
#' @examples 
#' 
#' df<- data.frame(SCI_NAME= "A", SiteID="1001",proportion="1.3") %>%
#'             dplyr::left_join(KBAscope::species)
#'
#' criterion_D(df)
#'
#'
#'
criterion_D<- function(x) {

  proportion=.=NULL

  #Test for criteria D1,D2,D3
  x<- x %>% dplyr::mutate(.,
  D1a= dplyr::case_when(proportion >= 1 ~ "D1a", TRUE ~ "NA"),
  Criterion_D2= dplyr::case_when(proportion >= 10 ~ "D2", TRUE ~ ""),
  Criterion_D3= dplyr::case_when(proportion >= 10 ~ "D3", TRUE ~ ""))

  x$D1b<- ifelse(x$SiteID %in% dplyr::top_n(x,10,proportion), "D1b", "NA")

  x<- x %>% dplyr::mutate(.,Criterion_D1= base::apply(sf::st_drop_geometry(
    .[, c("D1a","D1b")]), 1,function(y) paste0(y[!y=="NA"], collapse = ","))) %>%
    dplyr::select(-c("D1a","D1b"))

  base::return(x)
  }
