#' Identifies Whether a Species is Ecoregion or Bioregion Restricted
#'
#' @param x Object of class sf and data frame representing species data.
#' @param ecoregion Object of class sf and data frame that represents relevant ecoregion.
#' @param eco_name Object of class character. The column that represents the
#'                  ecoregion names.
#' @param bioregion Object of class sf and data frame that represents relevant bioregion.
#' @param bio_name Object of class character. The column that represents the
#'                  bioregion names.
#' @return object x with two new columns "Eco_BioRestricted" and "Eco_BioName"
#' @export
#'
#' @examples
#'
#' x<- KBAscope::species[1,] %>% dplyr::left_join(data.frame(ScientificName= "A",
#'   SCI_NAME="A", Range_Restricted="", Eco_BioRestricted="", TaxonomicGroup="",
#'   proportion=""))
#'
#' eco_bio_check(x,ecoregion=KBAscope::ecoregion,eco_name="ECO_NAME",
#'   bioregion=NULL, bio_name=NULL)
#'
#'
#'
eco_bio_check<- function(x,ecoregion= NULL,eco_name=NULL,bioregion=NULL,bio_name=NULL){

  #set some parameters
  sf::sf_use_s2(FALSE)
  scientific_name=.=NULL

  #Create function to apply per species
  eco<- function(y, df=eco_bioregion_restricted) {
    #Check first if species name is in the file provided by the KBA programme
    if(base::unique(y$ScientificName) %in% df$scientific_name){
      df<- df %>% dplyr::filter(scientific_name==unique(y$ScientificName))
      
      if(df$Restricted.to.Terrestrial.ecoregion=="TRUE"){
        y<- y %>% dplyr::mutate(Eco_BioRestricted= "B3a",Eco_bio_list="Yes",
          Eco_BioName=df$terrestrial_ecoregion_name)
      }
      if(df$Restricted.to.a.FW.ecoregion=="TRUE"){
        y<- y %>% dplyr::mutate(Eco_BioRestricted= "B3a",Eco_bio_list="Yes",
          Eco_BioName=df$freshwater_ecoregion_name)
      }
      if(df$Restricted.to.marine.ecoregion=="TRUE"){
        y<- y %>% dplyr::mutate(Eco_BioRestricted= "B3a",Eco_bio_list="Yes",
          Eco_BioName=df$marine_ecoregion_name)
      }
      if(df$Restricted.to.FW.bioregion=="TRUE"){
        y<- y %>% dplyr::mutate(Eco_BioRestricted= "B3b",Eco_bio_list="Yes",
          Eco_BioName=df$freshwater_bioregion_name)
      }
      if(df$Restricted.to.Marine.Bioregion=="TRUE"){
        y<- y %>% dplyr::mutate(Eco_BioRestricted= "B3b",Eco_bio_list="Yes",
          Eco_BioName=df$marine_bioregion_name)
      }
      base::return(y)
    #If not, intersect species distributions with relevant ecoregion or bioregion
    } else {
      #Check if ecoregion or bioregion is needed and intersect
      if(unique(y$TaxonomicGroup %in% c("Actinopterygii","Aves","Cephalaspidomorphi",
        "Ceratophyllales","Chondrichthyes","Mammalia","Myxini","Sarcoptergyii"))){
        if(base::is.null(bioregion)){
          y<- dplyr::mutate(y,Eco_BioRestricted= "No",Eco_bio_list="No",Eco_BioName="")
        }else{
          temp<- data.frame(sf::st_intersects(sf::st_make_valid(bioregion),
          sf::st_make_valid(y))) %>% dplyr::select(1) %>% dplyr::distinct()
        #If intersection shows that species is restricted
        if(nrow(temp)==1){
          y<- y %>% dplyr::mutate(Eco_BioRestricted= "B3b",Eco_bio_list="No",
            Eco_BioName= bioregion[[bio_name]][temp[1,1]])
        } else {
          y<- dplyr::mutate(y,Eco_BioRestricted= "No",Eco_bio_list="No",Eco_BioName="")
        }
        }
      } else {
        temp<- data.frame(sf::st_intersects(sf::st_make_valid(ecoregion),
          sf::st_make_valid(y))) %>% dplyr::select(1) %>% dplyr::distinct()
        #If intersection shows that species is restricted
        if(nrow(temp)==1){
          y<- y %>% dplyr::mutate(Eco_BioRestricted= "B3a",Eco_bio_list="No",
                                  Eco_BioName= ecoregion[[eco_name]][temp[1,1]])
        } else {
          y<- dplyr::mutate(y,Eco_BioRestricted= "No",Eco_bio_list="No",Eco_BioName="")
        }
        base::return(y)
      }
      base::return(y)
    }
  }

  #Apply eco function per species
  x %>% base::split(.$ScientificName) %>% base::lapply(., eco) %>%
    base::do.call(base::rbind,.)
}


