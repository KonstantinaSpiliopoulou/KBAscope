#' Edit spatial units to contain a unique ID column.
#'
#' @param x Object of class sf and data frame that represent the spatial
#'          unites data.
#' @param id Object of type character indicating the name of the ID column.
#'
#' @return A new ID column, if missing, and removed redundant columns.
#' @export
#'
#' @examples
#' 
#' spatial_units_edit(KBAscope::spatial_units,id="id")
#'
#'


spatial_units_edit<- function(x,id=NA){

  #Set parameters
  SiteID=geom=.=NULL

  #If there is no id column create one, else just change the name
  if(is.na(id)){
    x %>% dplyr::mutate(SiteID= paste0("ID_",1:nrow(x))) %>%
      dplyr::select(SiteID,geom)
  }else {
    x %>% dplyr::select(id,geom) %>% dplyr::rename(.,SiteID= id)
  }
}
