#' Creates a data frame with all the necessary information to apply KBA criteria.
#'
#' @param x Object of class data frame that contains the list of species.
#'          If the species are not assessed in the IUCN Red List of Threatened
#'          Species, x should contain the taxonomy of the species.
#' @param name Object of class character. The column containing the species name.
#' @param type Object of class character to identify the type of distribution
#'            data of x. Takes values "AOO", "AOH","localities" or "range_maps".
#' @param red_list If TRUE data are assessed in the IUCN Red List of Threatened
#'                Species. If FALSE data are not assessed in the IUCN Red List
#'                of Threatened Species.
#' @param red_list_info Object of class data frame created by
#'                      KBAscope::red_list_info().
#' @return Object of class data frame that contains all the necessary
#'        information to apply KBA criteria.
#' @export
#'
#' @examples
#'
#' if (FALSE){
#' species_info(KBAscope::species,name="SCI_NAME",
#'   red_list=TRUE,red_list_info)
#' }
#'
#'
species_info<- function(x,name,type= c("AOO", "AOH", "localities", "range_maps"),
                        red_list=TRUE,red_list_info=NULL){

  #Set parameters
  Sort.Order=PRESENCE=ORIGIN=SEASONAL=LEGEND=phylum=family=TaxonomicGroup=NULL

  #Edit data from KBA resources
  tax_groups<- dplyr::filter(taxonomic_groups,!is.na(Sort.Order)) %>%
    dplyr::add_row(Sort.Order=355,Kingdom=NULL,Phylum=NULL,Class=NULL,
    Order=NULL,Superfamily=NULL,Taxonomic.group.level="NA",
    Number.RR.species.required.at.KBA.with.1..range.for.B2=2,
    Area.for.25..B2.RR.definition..km2....otherwise.use.10.000.km2="10,000",
    Median.range.size.for.B3.assessment.for.comprehensively.assessed.species=NULL,
    Apply.Ecoregion..B3a..or.bioregion..B3b..restriction=NULL,Notes=NULL)
  tax_groups$Area.for.25..B2.RR.definition..km2....otherwise.use.10.000.km2[base::which(
    tax_groups$Area.for.25..B2.RR.definition..km2....otherwise.use.10.000.km2=="")]<- "10,000"

  #drop data geometry
  x<- sf::st_drop_geometry(x)

  #Cases when red lited or not
  if (red_list==FALSE){
    info<- x %>% dplyr::mutate(
    internalTaxonId="", CommonName="", TaxonomicGroup_KBA_dataForm="",
    GlobalRedListCategory="",AssessAgainstA1c_A1d="", AssessmentParameter="",
    Source="", DerivationOfEstimate="",SourceOfData="",Range_Restricted="",
    Eco_BioRestricted="", YearOfSiteValues="") %>%
    dplyr::select(6,7,1,8:17,2:5) %>% base::unique()
  } else{
    info<- base::merge(x,red_list_info, by.x= name, by.y="ScientificName", all.x=TRUE) %>%
      dplyr::select(-ASSESSMENT,-ID_NO,-COMPILER,-YEAR,-CITATION) %>%
      dplyr::rename(ScientificName=name)
  }

  #find taxonomic group
  info<- info %>% dplyr::rowwise() %>% dplyr::mutate(TaxonomicGroup =
    base::ifelse(phylum %in% tax_groups$Taxonomic.group.level, phylum,
      base::ifelse(class %in% tax_groups$Taxonomic.group.level, class,
        base::ifelse(order %in% tax_groups$Taxonomic.group.level, order,
          base::ifelse(family %in% tax_groups$Taxonomic.group.level, family,
            "NA"))))) %>% base::data.frame()

    #remove columns
    if(unique(c("PRESENCE","ORIGIN","SEASONAL") %in% names(info))){
      info<- dplyr::select(info,-PRESENCE,-ORIGIN,-SEASONAL) %>% unique()
    }
    #remove columns
    if("LEGEND" %in% names(info)){
      info<- dplyr::select(info,-LEGEND) %>% unique()
    }
    #add range restricted info
    if(length(unique(info$TaxonomicGroup))!=1){
    info<- info %>% dplyr::group_by(TaxonomicGroup) %>% dplyr::mutate(
      rr_size= unique(tax_groups$Area.for.25..B2.RR.definition..km2....otherwise.use.10.000.km2[which(
        tax_groups$Taxonomic.group.level==unique(TaxonomicGroup))]),
      B2_RR= unique(tax_groups$Number.RR.species.required.at.KBA.with.1..range.for.B2[base::which(
        tax_groups$Taxonomic.group.level==unique(TaxonomicGroup))])) %>%
        base::data.frame()

    } else {
      if(unique(info$TaxonomicGroup)=="NA"){
      info<- info %>% dplyr::mutate(rr_size="10,000", B2_RR=2) %>%
        base::data.frame()
      }
      if(unique(info$TaxonomicGroup)!="NA"){
        info<- info %>% dplyr::group_by(TaxonomicGroup) %>% dplyr::mutate(
          rr_size= unique(tax_groups$Area.for.25..B2.RR.definition..km2....otherwise.use.10.000.km2[which(
            tax_groups$Taxonomic.group.level==unique(TaxonomicGroup))]),
          B2_RR= unique(tax_groups$Number.RR.species.required.at.KBA.with.1..range.for.B2[base::which(
            tax_groups$Taxonomic.group.level==unique(TaxonomicGroup))])) %>%
            base::data.frame()
      }
    }

return(info)
}


