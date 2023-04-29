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
#' eco_info<- data.frame(scientific_name= "A",Restricted.to.Terrestrial.ecoregion="TRUE",
#'   Restricted.to.a.FW.ecoregion="",Restricted.to.marine.ecoregion="",
#'   Restricted.to.FW.bioregion="",Restricted.to.Marine.Bioregion="")
#'
#' eco_bio_check(x,ecoregion=KBAscope::ecoregion,eco_name="ECO_NAME",
#'   bioregion=NULL, bio_name=NULL)
#'
#'
#'
eco_bio_check<- function(x,ecoregion= NULL,eco_name=NULL,bioregion=NULL,bio_name=NULL){

  #set some parameters
  sf::sf_use_s2(FALSE)
  .=NULL

  #Create function to apply per species
  eco<- function(x) {
    #Check first if species name is in the file provided by the KBA programme
    if(unique(x$ScientificName) %in% eco_bioregion_restricted$scientific_name){


      if(eco_bioregion_restricted$Restricted.to.Terrestrial.ecoregion[which(
        eco_bioregion_restricted$scientific_name==x$ScientificName)]=="TRUE"){
          x<- x %>% dplyr::mutate(Eco_BioRestricted= "B3a",Eco_bio_list="Yes",
            Eco_BioName=eco_bioregion_restricted$terrestrial_ecoregion_name[which(
            eco_bioregion_restricted$scientific_name==x$ScientificName)])
      }
      if(eco_bioregion_restricted$Restricted.to.a.FW.ecoregion[which(
        eco_bioregion_restricted$scientific_name==x$ScientificName)]=="TRUE"){
          x<- x %>% dplyr::mutate(Eco_BioRestricted= "B3a",Eco_bio_list="Yes",
            Eco_BioName=eco_bioregion_restricted$freshwater_ecoregion_name[which(
            eco_bioregion_restricted$scientific_name==x$ScientificName)])
      }
      if(eco_bioregion_restricted$Restricted.to.marine.ecoregion[which(
        eco_bioregion_restricted$scientific_name==x$ScientificName)]=="TRUE"){
          x<- x %>% dplyr::mutate(Eco_BioRestricted= "B3a",Eco_bio_list="Yes",
            Eco_BioName=eco_bioregion_restricted$marine_ecoregion_name[which(
            eco_bioregion_restricted$scientific_name==x$ScientificName)])
      }
      if(eco_bioregion_restricted$Restricted.to.FW.bioregion[which(
        eco_bioregion_restricted$scientific_name==x$ScientificName)]=="TRUE"){
          x<- x %>% dplyr::mutate(Eco_BioRestricted= "B3b",Eco_bio_list="Yes",
            Eco_BioName=eco_bioregion_restricted$freshwater_bioregion_name[which(
            eco_bioregion_restricted$scientific_name==x$ScientificName)])
      }
      if(eco_bioregion_restricted$Restricted.to.Marine.Bioregion[which(
        eco_bioregion_restricted$scientific_name==x$ScientificName)]=="TRUE"){
        x<- x %>% dplyr::mutate(Eco_BioRestricted= "B3b",Eco_bio_list="Yes",
          Eco_BioName=eco_bioregion_restricted$marine_bioregion_name[which(
          eco_bioregion_restricted$scientific_name==x$ScientificName)])
      }
      base::return(x)


    #If not, intersect species distributions with relevant ecoregion or bioregion
    } else {


      #Check if ecoregion or bioregion is needed and intersect
      if(x$TaxonomicGroup %in% c("Actinopterygii","Aves","Cephalaspidomorphi",
        "Ceratophyllales","Chondrichthyes","Mammalia","Myxini","Sarcoptergyii")){
        temp<- data.frame(sf::st_intersects(sf::st_make_valid(bioregion),
          sf::st_make_valid(x))) %>% dplyr::select(1) %>% dplyr::distinct()
        #If intersection shows that species is restricted
        if(nrow(temp)==1){
          x<- x %>% dplyr::mutate(Eco_BioRestricted= "Yes",Eco_bio_list="No",
            Eco_BioName= bioregion[[bio_name]][temp[1,1]])
        } else {
          x<- dplyr::mutate(x,Eco_BioRestricted= "No",Eco_bio_list="No",Eco_BioName="")
        }

      } else {
        temp<- data.frame(sf::st_intersects(sf::st_make_valid(ecoregion),
          sf::st_make_valid(x))) %>% dplyr::select(1) %>% dplyr::distinct()
        #If intersection shows that species is restricted
        if(nrow(temp)==1){
          x<- x %>% dplyr::mutate(Eco_BioRestricted= "Yes",Eco_bio_list="No",
                                  Eco_BioName= ecoregion[[eco_name]][temp[1,1]])
        } else {
          x<- dplyr::mutate(x,Eco_BioRestricted= "No",Eco_bio_list="No",Eco_BioName="")
        }
      }

    base::return(x)
    }
  }

  #Apply eco function per species
  x %>% base::split(.$ScientificName) %>% base::lapply(., eco) %>%
    base::do.call(base::rbind,.)
}


