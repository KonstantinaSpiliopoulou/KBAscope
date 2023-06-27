#' Changes species data into format to apply KBA scoping analysis.
#'
#' @param x Object of class sf and data frame representing species data.
#' @param type Object of class character to identify the type of distribution
#'            data of x. Takes values "AOO", "AOH","localities" or "range_maps".
#' @param name Object of class character. The column that represents the
#'            scientific name of species.
#' @param species_info Object of class data frame that results from the
#'                    function in KBAscope 'species_info'.
#' @param system Object of class character. Takes values "terrestrial",
#'                "freshwater" or "marine".
#'
#' @return Object of class sf and data frame representing species data in
#'        the format that a KBA scoping analysis can be performed.
#' @export
#'
#' @examples
#'
#' if (FALSE){
#' x<- KBAscope::species %>% dplyr::mutate(ScientificName="A")
#'           RL<- red_list_info(KBAscope::taxonomy, KBAscope::assessment,
#'            KBAscope::common_names)
#'
#' species_edit(x, type="range_maps", name="SCI_NAME",species_info=RL,
#'   system="terrestrial")
#' }
#'
#'
species_edit<- function(x,type= c("AOO", "AOH", "localities", "range_maps"),
                        name,species_info,system="terrestrial"){
  #set parameters
  PRESENCE=ORIGIN=SEASONAL=ID_NO=SCI_NAME=LEGEND=desc=geom=.=km=NULL
  GlobalRange=rr_size=Range_Restricted=TaxonomicGroup=SCIENTIFICNAME=NULL
  ScientificName=geom=st_area=NULL

  #Comprehensively assessed taxa
  comp_assessed<- c("Mammalia", "Aves", "Amphibia","Reptilia","Actinopterygii",
                    "Chondrichthyes","Cephalaspidomorphi","Myxini",
                    "Sarcopterygii","Odonata", "Ceratophyllales","Proteales")

  #Combine data with species information
  x<- dplyr::mutate(x, ScientificName = name)
  x<- dplyr::left_join(x,species_info)
  sf::sf_use_s2(FALSE)

  #Take cases according to data type
  if(type=="range_maps"){
    base::colnames(x) [1:(base::ncol(x)-21)]<- base::toupper(base::names(x)[1:(base::ncol(x)-21)])
    #x<- dplyr::mutate(x, ScientificName = SCIENTIFICNAME)

    #range maps function to edit range maps
    range_maps<- function(y) {
    # filter species polygons based on IUCN Red List coding
     if (base::unique(y$CLASS)== "Aves" & TRUE %in% (c(2,3) %in% y$SEASONAL)){
      rem<- c(1,4,5)
      code<- base::unique(y$SEASONAL); code<- code[!code %in% rem]

      if (2 %in% code & 3 %in% code){
        ranges_breeding<- y %>%
          dplyr::filter(PRESENCE %in% c(1,2) & ORIGIN %in% c(1,2) & SEASONAL %in% c(1,2))
        ranges_non_breeding<- y %>%
          dplyr::filter(PRESENCE %in% c(1,2) & ORIGIN %in% c(1,2) & SEASONAL %in% c(1,3))
        #Extract relevant information and merge them to final maps
        info1<- ranges_breeding %>% sf::st_drop_geometry() %>%
          dplyr::select(ID_NO, ScientificName, LEGEND) %>%
          dplyr::mutate(
            LEGEND= base::sub(")", "", base::sub(".*\\(", "",base::as.character(LEGEND))))%>%
          dplyr::distinct() %>%
          dplyr::arrange(desc(LEGEND)) %>% dplyr::group_by(ID_NO, ScientificName) %>%
          dplyr::mutate(LEGEND = base::paste(LEGEND, collapse=", ")) %>% base::unique()
        info2<- ranges_non_breeding %>% sf::st_drop_geometry() %>%
          dplyr::select(ID_NO, ScientificName, LEGEND) %>%
          dplyr::mutate(
            LEGEND= base::sub(")", "", base::sub(".*\\(", "",base::as.character(LEGEND))))%>%
          dplyr::distinct() %>% dplyr::arrange(desc(LEGEND)) %>%
          dplyr::group_by(ID_NO, ScientificName) %>%
          dplyr::mutate(LEGEND = base::paste(LEGEND, collapse=", ")) %>% base::unique()
        #Dissolve polygons
        df1<- ranges_breeding %>% sf::st_make_valid() %>% dplyr::group_by(ID_NO) %>%
          dplyr::reframe(geom= sf::st_union(geom)) %>% base::data.frame() %>%
          sf::st_as_sf() %>% dplyr::left_join(.,info1) %>% base::unique()
        df2<- ranges_non_breeding %>% sf::st_make_valid() %>% dplyr::group_by(ID_NO) %>%
          dplyr::reframe(geom= sf::st_union(geom)) %>% base::data.frame() %>%
          sf::st_as_sf() %>% dplyr::left_join(.,info2) %>% base::unique()

        y<- base::rbind(df1,df2) %>% base::unique()
      }else{
        ranges<- y %>%
          dplyr::filter(PRESENCE %in% c(1,2) & ORIGIN %in% c(1,2) & SEASONAL %in% c(1,code))
        #Extract relevant information and merge them to final maps
        info1<- ranges %>% sf::st_drop_geometry() %>%
          dplyr::select(ID_NO, ScientificName, LEGEND) %>%
         dplyr::mutate(
          LEGEND= base::sub(")", "", base::sub(".*\\(", "",base::as.character(LEGEND))))%>%
          dplyr::distinct() %>% dplyr::arrange(desc(LEGEND)) %>%
          dplyr::group_by(ID_NO, ScientificName) %>%
          dplyr::reframe(LEGEND = base::paste(LEGEND, collapse=", "))
        #Dissolve polygons
        y<- ranges %>% dplyr::group_by(ID_NO) %>%
          dplyr::reframe(geom= sf::st_union(geom)) %>% base::data.frame() %>%
          sf::st_as_sf() %>% dplyr::left_join(.,info1, by= "ID_NO")
      }

       y<- y %>% dplyr::select(-ID_NO) %>% dplyr::left_join(., species_info,
        by="ScientificName") %>%
        dplyr::mutate(Eco_bio_system= system,
        GlobalRange= base::as.numeric(units::set_units(sf::st_area(.), km^2)),
        Range_Restricted= base::ifelse(GlobalRange>=rr_size,"Yes","No"))

        y<- y%>% dplyr::mutate(RR_determined= base::ifelse(Range_Restricted=="Yes",
          base::ifelse(TaxonomicGroup %in% comp_assessed,
                       "25th percentile","10,000 km2"),"n/a"))
       return(y)

    } else {

      y<- y %>% dplyr::select(ScientificName,PRESENCE,ORIGIN,SEASONAL,LEGEND,geom) %>%
        dplyr::filter(PRESENCE %in% c(1,2) & ORIGIN %in% c(1,2) & SEASONAL == 1) %>%
        dplyr::group_by(ScientificName) %>% dplyr::reframe(geom= sf::st_union(geom)) %>%
        base::as.data.frame() %>% sf::st_as_sf() %>% sf::st_make_valid() %>%
        sf::st_transform(.,"EPSG:4326") %>%
        dplyr::left_join(.,species_info,by="ScientificName") %>%
        dplyr::mutate(LEGEND= "Extant") %>%
        dplyr::mutate(Eco_bio_system= system,
        GlobalRange= base::as.numeric(units::set_units(sf::st_area(.), km^2)),
        Range_Restricted= base::ifelse(GlobalRange>=rr_size,"Yes","No"))

      y<- y%>% dplyr::mutate(RR_determined= base::ifelse(Range_Restricted=="Yes",
        base::ifelse(TaxonomicGroup %in% comp_assessed,
                     "25th percentile","10,000 km2"),"n/a"))
      return(y)
      }
  }

  #apply range map function and write outputs
   x<- x %>% base::split(x$ScientificName) %>% base::lapply(., range_maps) %>%
     base::do.call(base::rbind,.)
  #wrrite outputs
   x %>% base::split(x$ScientificName) %>% base::lapply(., function(y)
     sf::st_write(y,base::paste0("input/species/",system,"/",type,
     "/",base::unique(y$ScientificName),".gpkg"), row.names=FALSE))
  }

  #Take cases according to data type
  if(type=="localities"){
    x %>% dplyr::mutate(.,AssessmentParameter="(v) number of localities",
      DerivationOfEstimate="Estimated from mapping") %>%
      base::split(x$ScientificName) %>% lapply(.,function(x) dplyr::mutate(x,
      GlobalRange= base::nrow(x))) %>% lapply(., function(y) sf::st_write(y,
      base::paste0("input/species/",system,"/",type,"/",
      base::unique(y$ScientificName),".gpkg"),row.names=FALSE))
  }

  #Take cases according to data type
  if(type %in% c("AOH", "AOO")){
    x<- x %>% dplyr::group_by(ScientificName) %>%
      dplyr::reframe(geom= sf::st_union(geom)) %>% base::as.data.frame() %>%
      sf::st_as_sf() %>% sf::st_make_valid() %>% dplyr::left_join(.,species_info) %>%
      dplyr::mutate(GlobalRange= as.numeric(units::set_units(st_area(.), km^2)))
      if(type=="AOH"){
        x<- x %>% dplyr::mutate(
          AssessmentParameter="(iii) extent of suitable habitat",
          DerivationOfEstimate="Estimated from mapping")
      }else{
        x<- x %>% dplyr::mutate(AssessmentParameter="(ii) area of occupancy",
                   DerivationOfEstimate="Estimated from mapping")
      }
    x %>% base::split(x$ScientificName) %>%
      lapply(., function(y) sf::st_write(y,
      base::paste0("input/species/",system,"/",type,
      "/",base::unique(y$ScientificName),".gpkg"),row.names=FALSE))
  }

  #Take cases according to data type
  if(type=="population"){
    x %>% utils::write.csv(base::paste0("input/species/",system,"/",type,
      "/population.csv"), row.names=FALSE)
  }
}
