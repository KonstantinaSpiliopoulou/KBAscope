#' Generates potential KBA sites and the specie that trigger KBA criteria.
#'
#' @param x The directory under which inputs and outputs of a KBA scoping
#'          analysis are stored.
#' @param system Object of class character. Takes values "terrestrial",
#'              "freshwater" or "marine".
#' @param output Object of class character. Defines the output file type.
#'              Default is ".gpkg" which stands for GEOPACKAGE.
#'
#' @return Creates output files 'potential_KBAs.gpkg', 'ptrigger_species.gpkg'
#'        and  'ptrigger_species.csv' under results folder.
#' @export
#'
#' @examples 
#' 
#' \dontrun{
#'   df<- "C:/projects/KBA_scoping_analysis"
#'   potential_kbas(df, system="terrestrial", output=".gpkg" )
#' }
#'
potential_kbas<- function(x,system="terrestrial", output=".gpkg"){

  #Set parameters
  Criterion_B2=Criterion_B3=SiteID=TaxonomicGroup=ScientificName=nB2=B2_RR=NULL
  site_B2=site_B3=geom=nB3=.=Criteria=NULL
  sf::sf_use_s2(FALSE)
  #Load all files under output folder
  files<- base::list.files(path=base::paste0(x,"/output/",system), recursive=T)
  ptriggers<- base::lapply(files,
    function(y) sf::st_read(base::paste0(x,"/output/",system,"/",y),
                            stringsAsFactors=FALSE)) %>%
    plyr::ldply(data.frame) %>% sf::st_sf() %>% sf::st_buffer(., 0.0) %>% 
    sf::st_make_valid() %>% sf::st_transform(crs = 4326)
  
  #Filter out species that meet only B2 and B3 criteria but do not meet the site threshold
  B2.B3<- ptriggers %>% dplyr::filter(Criterion_B2=="B2"| Criterion_B3=="B3") %>%
    dplyr::group_by(SiteID, TaxonomicGroup, Criterion_B2) %>%
    dplyr::add_tally(dplyr::n_distinct(ScientificName),name="nB2") %>%
    dplyr::mutate(site_B2=base::ifelse(Criterion_B2=="B2" & nB2>=B2_RR,"Yes","No")) %>%
    dplyr::group_by(SiteID, TaxonomicGroup, Criterion_B3) %>%
    dplyr::add_tally(dplyr::n_distinct(ScientificName),name = "nB3") %>%
    dplyr::mutate(site_B3=base::ifelse(Criterion_B3=="B3" & nB3>=5,"Yes","No"))

  ptriggers<- ptriggers %>% dplyr::mutate(nB2=0, site_B2="No", nB3=0, site_B3="No") %>%
    dplyr::filter(!(Criterion_B2== "B2" | Criterion_B3== "B3")) %>%
    base::rbind(.,B2.B3) %>%
    dplyr::filter(!(Criteria== "B2" & site_B2== "No")) %>%
    dplyr::filter(!(Criteria== "B3" & site_B3== "No")) %>%
    dplyr::filter(!(Criteria== "B2,B3" & site_B2== "No" & site_B3== "No")) %>%
    dplyr::arrange(SiteID)

  #Correct geometry collections
  if ("GEOMETRYCOLLECTION"%in% sf::st_geometry_type(ptriggers)== TRUE){ #start of if
    gem<- sf::st_cast(ptriggers)[which(sf::st_is(sf::st_cast(ptriggers),
    "GEOMETRYCOLLECTION")),] %>% sf::st_buffer(.,0.0)%>% sf::st_make_valid() %>%
      sf::st_cast("MULTIPOLYGON")
    ptriggers<-sf::st_cast(ptriggers)[which(!sf::st_is(sf::st_cast(ptriggers),
      "GEOMETRYCOLLECTION")),]
    ptriggers<- base::rbind(ptriggers,gem)
  } #end of if

  #Polygonize grids and create potential KBA sites
  grid<- ptriggers %>% dplyr::group_by(SiteID) %>%
    dplyr::summarise(geometry= sf::st_union(geom)) %>%
    base::data.frame() %>% sf::st_as_sf() %>%
    dplyr::mutate(SiteID= base::paste0("pKBA_",1:base::nrow(.)))

  #Write geopackage outputs
  sf::st_write(grid, base::paste0(x,"results/",system,"/potential_KBAs",output),
    row.names=FALSE)
  sf::st_write(ptriggers, base::paste0(x,"results/",system,"/ptrigger_species",
    output),row.names=FALSE)

  #Write csv output for trigger species
  ptriggers<- sf::st_drop_geometry(ptriggers)
  utils::write.csv(ptriggers,
    base::paste0(x,"results/",system,"/ptrigger_species.csv"),row.names=FALSE)
}
