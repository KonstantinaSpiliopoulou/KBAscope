#' Pre-populates KBA data forms with KBA scoping analysis results.
#'
#' @param x Object of class data frame. The "trigger_species.csv" file generated
#'          from KBAscope::potential_kbas.
#'
#' @return Generates pre-populated KBA data forms under results folder.
#' @export
#'
#' @examples
#' \dontrun{
#'   df<- sf::st_drop_geometry(triggers_gis)
#'
#'   kba_dataforms(df)
#' }
#'
kba_dataforms<- function(x){

  #Set parameters
  SiteID=CommonName=ScientificName=TaxonomicGroup=GlobalRedListCategory=NULL
  AssessmentParameter=GlobalRange=Source=Range_Restricted=Eco_BioName=NULL
  SourceOfData=YearOfSiteValues=internalTaxonId=proportion=System=NULL
  Eco_bio_list=AssessAgainstA1c_A1d=SiteRange=DerivationOfEstimate=NULL
  Eco_BioRestricted=Eco_bio_system=RR_determined=data_form_multi_site=NULL

  #Select data to be used in the KBA data form
  vars<- c("SiteID", "internalTaxonId", "CommonName", 
           "ScientificName","TaxonomicGroup", "GlobalRedListCategory",
           "AssessAgainstA1c_A1d","AssessmentParameter", "GlobalRange", "GlobalRange", 
           "GlobalRange","Source","Range_Restricted","RR_determined", 
           "Eco_BioRestricted", "Eco_BioName","Eco_bio_system", "Eco_bio_list",
           "SiteRange", "SiteRange", "SiteRange", "DerivationOfEstimate", "SourceOfData",
           "YearOfSiteValues","proportion")
  x<- x %>% dplyr::select(tidyselect::all_of(vars)) %>% base::unique()

  #Assign them to different vectors
  a<- x %>% dplyr::select(tidyselect::all_of("SiteID"))
  a1<- x %>% dplyr::select(tidyselect::all_of("internalTaxonId"))
  vars<- c("CommonName", "ScientificName", "TaxonomicGroup","GlobalRedListCategory")
  b<- x %>% dplyr::select(tidyselect::all_of(vars))
  vars<- c("AssessAgainstA1c_A1d","Range_Restricted","RR_determined",
           "Eco_BioRestricted","Eco_bio_system","Eco_BioName",
           "Eco_bio_list","AssessAgainstA1c_A1d","Range_Restricted","RR_determined",
           "Eco_BioRestricted","Eco_bio_system","Eco_BioName","Eco_bio_list")
  c<- x %>% dplyr::select(tidyselect::all_of(vars))
  vars<- c("AssessmentParameter", "GlobalRange", "GlobalRange","GlobalRange",
           "DerivationOfEstimate")
  d<- x %>% dplyr::select(tidyselect::all_of(vars))
  e<- x %>% dplyr::select(tidyselect::all_of("proportion"))

  #Load KBA data form
  wb<- KBAscope::data_form_multi_site
  
  #Assign vectors to specified columns
  openxlsx::writeData(wb, x=a, sheet = "3. Biodiversity elements data",
                        startRow = 5, startCol = 2, colNames = FALSE)
  openxlsx::writeData(wb, x=a1, sheet = "3. Biodiversity elements data",
                        startRow = 5, startCol = 4, colNames = FALSE)
  openxlsx::writeData(wb, x=b, sheet = "3. Biodiversity elements data",
                        startRow = 5, startCol = 7, colNames = FALSE)
  openxlsx::writeData(wb, x=c, sheet = "3. Biodiversity elements data",
                        startRow = 5, startCol = 13, colNames = FALSE)
  openxlsx::writeData(wb, x=d, sheet = "3. Biodiversity elements data",
                        startRow = 5, startCol = 21, colNames = FALSE)
  openxlsx::writeData(wb, x=e, sheet = "3. Biodiversity elements data",
                        startRow = 5, startCol = 62, colNames = FALSE)

  #write xlsx file
  openxlsx::saveWorkbook(wb, 
    "C:/Users/Kspil/OneDrive/Text/Papers/KBAs-Greece/KBA_scoping_script/KBA_dataform.xlsx", 
    overwrite = TRUE)

}
