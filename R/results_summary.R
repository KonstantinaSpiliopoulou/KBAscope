#' Generates summary file of results.
#'
#' @param x Object of class data frame. The "trigger_species.csv" file
#'          generated from KBAscope::potential_kbas.
#' @param path Path of the directory to save outputs.
#'
#' @return Creates output "results_summary.xlsx" under results folder.
#' @export
#'
#' @examples
#' 
#' \dontrun{
#'   df<- data.frame(Criteria="",SiteID="",TaxonomicGroup="",ScientificName="",
#'     Criterion_A1="",Criterion_B1="",Criterion_B2="",Criterion_B3="",
#'     site_B2="",B2_RR="",nB2="",site_B3="",nB3="")
#'
#'   results_summary(df, path="C:/projects/KBA_scoping_analysis/results/")
#' }   
#'
#'
results_summary<- function(x,path=NULL){

  #Set parameters
  Criteria=SiteID=TaxonomicGroup=ScientificName=Criterion_A1=NULL
  Criterion_B3=.=site_B2=B2_RR=nB2=site_B3=nB3=Criterion_B1=Criterion_B2=NULL

  #Summary for trigger species
  sum_trigger_species<- x %>% dplyr::filter(Criteria!="") %>%
    dplyr::select(c(SiteID,TaxonomicGroup,ScientificName,Criterion_A1,
    Criterion_B1,Criterion_B2,Criterion_B3,Criteria)) %>% base::unique()
  siteid_species<- sum_trigger_species %>%
    dplyr::group_by(SiteID,TaxonomicGroup) %>%
    dplyr::tally(dplyr::n_distinct(ScientificName)) %>%
    dplyr::left_join(.,sum_trigger_species)
  #Summary of trigger sites B2
  sum_trigger_sitesB2<- x %>%
    dplyr::filter(Criterion_B2 == "B2" & site_B2=="Yes") %>%
    dplyr::select(SiteID,TaxonomicGroup,B2_RR,nB2,site_B2) %>% base::unique()
  #Summary of trigger sites B3
  sum_trigger_sitesB3<- x %>%
    dplyr::filter(Criterion_B3 == "B3" & site_B3=="Yes") %>%
    dplyr::select(SiteID,TaxonomicGroup,nB3,site_B3) %>% base::unique()

  #write output
  wb <- openxlsx::createWorkbook()
  openxlsx::addWorksheet(wb, "Potential Trigger Species")
  openxlsx::addWorksheet(wb, "Potential Trigger Sites B2")
  openxlsx::addWorksheet(wb, "Potential Trigger Sites B3")
  #put the data into the workbook
  openxlsx::writeData(wb, sheet=1, siteid_species)
  openxlsx::writeData(wb, sheet=2, sum_trigger_sitesB2)
  openxlsx::writeData(wb, sheet=3, sum_trigger_sitesB3)
  #save file
  openxlsx::saveWorkbook(wb, base::paste0(path,"/results_summary.xlsx"),
    overwrite = TRUE)
}
