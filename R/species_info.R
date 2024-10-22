#' Creates a data frame with all the necessary information to apply KBA criteria.
#'
#' @param x Object of class data frame that contains the list of species.
#'          If the species are not assessed in the IUCN Red List of Threatened
#'          Species, x should contain the taxonomy of the species.
#' @param name Object of class character. The column containing the species name.
#' @param red_list If TRUE data are assessed in the IUCN Red List of Threatened
#'                Species. If FALSE data are not assessed in the IUCN Red List
#'                of Threatened Species.
#' @param taxonomy_info Object of class data frame created by
#'              KBAscope::red_list_info() or manually for species not assessed in 
#'              the IUCN Red List of Threatened Species.
#' @return Object of class data frame that contains all the necessary
#'        information to apply KBA criteria.
#' @export
#'
#' @examples
#' \dontrun{
#'   species_info(KBAscope::species,name="SCI_NAME", red_list=TRUE,info= info)
#' }
#'
#'
species_info<- function(x,name, red_list=TRUE,taxonomy_info=NULL){

  #Set parameters
  Sort.Order=PRESENCE=ORIGIN=SEASONAL=LEGEND=phylum=family=TaxonomicGroup=NULL
  superfamily=ASSESSMENT=ID_NO=COMPILER=YEAR=CITATION=.=NULL
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
  tax_groups<- dplyr::left_join(tax_groups, superfamily_lookup,
                                by= c("Superfamily" = "superfamily"))
  #drop data geometry
  x<- sf::st_drop_geometry(x)%>% dplyr::rename("ScientificName" = all_of(name))

  #Cases when red lited or not
  if (red_list==FALSE){
    info<- x %>% dplyr::left_join(.,taxonomy_info) %>%
      dplyr::rename(ScientificName=all_of(name)) %>% dplyr::mutate(internalTaxonId="", 
        CommonName="",GlobalRedListCategory="Not assessed",AssessAgainstA1c_A1d="No",
        AssessmentParameter="",Source="", DerivationOfEstimate="",
        SourceOfData="",Range_Restricted="",Eco_BioRestricted="", 
        YearOfSiteValues="") %>% base::unique()
  } else{
    info<- x %>% dplyr::left_join(.,taxonomy_info)
    base::colnames(info)[base::which(names(info) == name)]<- "ScientificName"
  }

  #find taxonomic group
  info<- info %>% dplyr::rowwise() %>% dplyr::mutate(TaxonomicGroup =
    base::ifelse(phylum %in% tax_groups$Taxonomic.group.level, phylum,
      base::ifelse(class %in% tax_groups$Taxonomic.group.level, class,
        base::ifelse(order %in% tax_groups$Taxonomic.group.level, order,
          base::ifelse(family %in% tax_groups$family, 
          tax_groups$Taxonomic.group.level[which(tax_groups$family==family)],"NA"))))) %>%
            base::data.frame()
  info$TaxonomicGroup[is.na(info$TaxonomicGroup)] <- "NA"
    #remove columns
    if(unique(c("PRESENCE","ORIGIN","SEASONAL") %in% names(info))){
      info<- dplyr::select(info,-PRESENCE,-ORIGIN,-SEASONAL) %>% unique()
    }
    #remove columns
    if("LEGEND" %in% names(info)){
      info<- dplyr::select(info,-LEGEND) %>% unique()
    }
    #remove columns
    if(unique(c("ASSESSMENT","ID_NO") %in% names(info))){
    info<- dplyr::select(info,-ASSESSMENT,-ID_NO) %>%
      unique()
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


