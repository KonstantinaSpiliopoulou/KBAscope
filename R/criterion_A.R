#' Tests against KBA criteria for A:Threatened Biodiversity
#'
#' @param x Object of class sf and data frame with all relevant information to
#'          apply KBA criterion A.
#'
#' @return x with a new column Criterion_A1.
#' @export
#'
#' @examples
#'
#' df<- data.frame(SCI_NAME= "A",GlobalRedListCategory="", AssessAgainstA1c_A1d="",
#'           proportion="") %>% dplyr::left_join(KBAscope::species)
#'
#' criterion_A(df)
#'
#'
criterion_A <- function(x) {
  .=NULL

  x %>% dplyr::mutate(.,
  A1d =  dplyr::case_when(GlobalRedListCategory == "Vulnerable (VU)" &
                    AssessAgainstA1c_A1d == "Yes" &
                    proportion >= 0.2 ~ "A1d", TRUE ~ "NA"),
  A1b = dplyr::case_when(GlobalRedListCategory == "Vulnerable (VU)" &
                    proportion >= 1 ~ "A1b", TRUE ~ "NA"),
  A1e = dplyr::case_when(GlobalRedListCategory %in% c("Critically Endangered (CR)",
                    "Endangered (EN)") & proportion >= 95 ~ "A1e", TRUE ~ "NA"),
  A1c = dplyr::case_when(GlobalRedListCategory %in% c("Critically Endangered (CR)",
                    "Endangered (EN)") & AssessAgainstA1c_A1d == "Yes" &
                    proportion >= 0.1 ~ "A1c", TRUE ~ "NA"),
  A1a = dplyr::case_when(GlobalRedListCategory %in% c("Critically Endangered (CR)",
                    "Endangered (EN)") & proportion >= 0.5 ~ "A1a", TRUE ~ "NA")) %>%
  dplyr::mutate(.,
    Criterion_A1= base::apply(sf::st_drop_geometry(.[, c("A1a","A1b","A1c","A1d","A1e")]), 1,
    function(y) paste0(y[!y=="NA"], collapse = ","))) %>%
    dplyr::select(-c("A1a","A1b","A1c","A1d","A1e"))
}
