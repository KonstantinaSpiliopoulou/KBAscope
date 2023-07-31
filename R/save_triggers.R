#' Saves output per species triggering KBA criteria
#'
#' @param x Object of class sf and data frame representing species data.
#' @param type Object of class character to identify the type of distribution
#'              data of x.Takes values "AOO", "AOH","localities",
#'              "population" or "range_maps".
#' @param path Path of the directory to save outputs.
#' @param output Object of class character. Defines the output file type.
#'                Default is ".gpkg" which stands for GEOPACKAGE.
#'
#' @return Saves outputs of potential KBA sites per species that triggers
#'        KBA criteria.
#' @export
#'
#' @examples
#' \dontrun{
#' df<- KBAscope::species[1,-3] %>% cbind(data.frame(ScientificName=c("A"),
#'           Criteria=c("A1a,B1")))
#'
#' save_triggers(df, type="range_maps",path=NULL, output=".gpkg")
#'
#'}
#'

save_triggers<- function(x,type=c("AOO", "AOH", "localities",
                                  "range_maps","population"),
                         path=NULL, output=".gpkg"){

  #Set parameters
  Criteria=.=NULL

  #If there is at least one criterion met once
  if(base::nrow(dplyr::filter(x, Criteria!=""))!=0){
    #Different approach for population data and the rest of the parameters
    if(type=="population"){
      x %>% dplyr::filter(Criteria!="") %>% base::split(.,"ScientificName") %>%
        base::lapply(., function(y) sf::st_write(y,base::paste0(
          path,"/",base::unique(y$ScientificName),output),
          stringsAsFactors=FALSE))
    }else{
      x %>% dplyr::filter(Criteria!="") %>% sf::st_write(.,base::paste0(
        path,base::unique(x$ScientificName),output),
        stringsAsFactors=FALSE)}
  }
  }
