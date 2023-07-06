#' Tests against KBA criteria for B:Geographically Restricted Biodiversity
#'
#' @param x Object of class sf and data frame with all relevant information to
#'          apply KBA criteria B1, B2 and B3.
#' @param criterion Object of class character. Takes values "B1","B2" and/or"B3".
#'
#' @return x with three new columns Criterion_B1, Criterion_B2, Criterion_B3.
#' @export
#'
#' @examples
#' df<- data.frame(SCI_NAME= "A",Range_Restricted="", Eco_BioRestricted="",
#'   TaxonomicGroup="", proportion="") %>% dplyr::left_join(KBAscope::species)
#'
#' criterion_B(df)
#'
criterion_B<- function(x, criterion= c("B1","B2","B3")) {

  .=NULL
  #Test for criterion B1
  if("B1" %in% criterion){
    x<- x %>% dplyr::mutate(.,
      Criterion_B1 = dplyr::case_when(proportion >= 10 ~ "B1", TRUE ~ ""))
  }
  #Test for criterion B2
  if("B2" %in% criterion){
    if(unique(x$TaxonomicGroup)== "NA"){
      x<- x %>% dplyr::mutate(.,Criterion_B2= "")
    }else{
      x<- x %>% dplyr::mutate(.,
        Criterion_B2= dplyr::case_when(
        Range_Restricted == "Yes" & proportion >= 1 ~ "B2", TRUE ~ ""))
    }
  }
  #Test for criterion B3
  if("B3" %in% criterion){
    if(unique(x$TaxonomicGroup)== "NA"){
      x<- x %>% dplyr::mutate(.,Criterion_B3= "")
    }else{
      x<- x %>% dplyr::mutate(
        Criterion_B3= dplyr::case_when(
        Eco_BioRestricted %in% c("B3a","B3b") & proportion >= 0.5 ~ "B3", TRUE ~ ""))
    }
  }

  return(x)
}

