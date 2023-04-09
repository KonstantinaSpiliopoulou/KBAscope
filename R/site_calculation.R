#' Calculates the site population size.
#'
#' @param x Object of class sf and data frame representing species data.
#' @param spatial_units Object of class sf and data frame that represent the
#'                      spatial unites data.
#' @param type Object of class character to identify the type of distribution
#'              data of x.Takes values "AOO", "AOH","localities",
#'              "population" or "range_maps".
#'
#' @return The intersection of x and spatial_units.
#' @export
#'
#' @examples
#'
#' spatial_units<- KBAscope::spatial_units %>% dplyr::rename(SiteID= id) %>%
#'   dplyr::mutate(SiteRange=10,GlobalRange=100)
#'
#' site_calculation(KBAscope::species, spatial_units, type="range_maps")
#'
#'
site_calculation<- function(x, spatial_units,
              type=c("AOO", "AOH", "localities", "range_maps","population")){

  #Set parameters
  id=.=SiteID=LEGEND=geom=km=Site_min=Global_min=SiteRange=GlobalRange=NULL

  #Data type range maps
  if(type=="range_maps"){
    #intersect species and spatial units
    x<- spatial_units %>%  dplyr::mutate(id = rownames(.)) %>%
      dplyr::filter(id %in% base::unlist(sf::st_intersects(x,.))) %>%
      sf::st_intersection(x,.) %>% dplyr::select(-id)
    #calculate SiteRange
    species_info<- x %>% sf::st_drop_geometry() %>%
      dplyr::group_by(SiteID,LEGEND) %>% base::unique()
    x<- x %>% dplyr::group_by(SiteID,LEGEND) %>%
      dplyr::reframe(geom=sf::st_union(geom)) %>%
      base::data.frame() %>% sf::st_as_sf()
    x<- x %>% dplyr::left_join(.,species_info, by= c("SiteID","LEGEND")) %>%
      dplyr::mutate(
      SiteRange= base::as.numeric(units::set_units(sf::st_area(.),km^2)))
  }

  #Data type localities
  if(type=="localities"){
    #intersect species and spatial units
    x<- spatial_units %>%  dplyr::mutate(id = rownames(.)) %>%
      dplyr::filter(id %in% base::unlist(sf::st_intersects(x,.))) %>%
      sf::st_intersection(x,.) %>% dplyr::select(-id)
    #calculate SiteRange
    temp1<- spatial_units %>% dplyr::mutate(id = rownames(.)) %>%
      dplyr::filter(id %in% base::unlist(sf::st_intersects(x,.))) %>%
      dplyr::select(-id)
    temp2<- x %>% sf::st_drop_geometry() %>% dplyr::group_by(SiteID) %>%
      dplyr::tally(name="SiteRange")
    x<- x %>% sf::st_drop_geometry() %>% dplyr::left_join(temp2) %>%
      dplyr::left_join(temp1) %>%
      sf::st_as_sf() %>% base::unique()
  }

  #Data type AOH or AOO
  if(type %in% c("AOH", "AOO")){
    #intersect species and spatial units
    x<- spatial_units %>%  dplyr::mutate(id = rownames(.)) %>%
      dplyr::filter(id %in% base::unlist(sf::st_intersects(x,.))) %>%
      sf::st_intersection(x,.) %>% dplyr::select(-id)
    #calculate SiteRange
    species_info<- x %>% sf::st_drop_geometry() %>%
      dplyr::group_by(SiteID) %>% base::unique()
    x<- x %>% dplyr::group_by(SiteID) %>%
      dplyr::reframe(geom=sf::st_union(geom)) %>%
      base::data.frame() %>% sf::st_as_sf()
    x<- x %>% dplyr::left_join(.,species_info, by= c("SiteID")) %>%
      dplyr::mutate(
      SiteRange= base::as.numeric(units::set_units(sf::st_area(.),km^2)))
  }

  #Data type population
  if(type=="population"){
    #add spatial units
    x<- spatial_units %>% dplyr::left_join(.,x) %>% sf::st_as_sf()
  }

  #get the proportion of site to global range
  if(type=="population"){
    x<- x %>% dplyr::mutate(proportion=(Site_min/Global_min)*100)
  } else {
    x<- x %>% dplyr::mutate(proportion=(SiteRange/GlobalRange)*100)
  }

base::return(x)
}
