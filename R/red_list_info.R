#' Combines the required information from the IUCN Red List of Threatened Species
#'
#' @param taxonomy Object of class data frame from the IUCN Red List website
#'                that contains the taxonomy of species.
#' @param assessment Object of class data frame from the IUCN Red List website
#'                  that contains the details of the species assessments.
#' @param common_names Object of class data frame from the IUCN Red List website
#'                      that contains the common names of species.
#'
#' @return Object of class data frame that includes the information from taxonomy,
#'          assessments and common names files combined.
#' @export
#'
#' @examples
#' red_list_info(KBAscope::taxonomy, KBAscope::assessment, KBAscope::common_names)
#'
#'
#'

red_list_info<- function(taxonomy, assessment, common_names){

  #Create a list of the files
  df_list <- list(taxonomy, assessment,
    common_names[which(common_names$main == "true"),])
  #Merge list files
  x <- base::Reduce(function(d1, d2) base::merge(d1, d2,
    by = "internalTaxonId", all.x = TRUE, all.y = TRUE),df_list)

  #Fix columns
  x<- x[!base::duplicated(x[,1]),]
  x<- x[,c("internalTaxonId","name","scientificName.x","className",
    "redlistCategory","redlistCriteria","assessmentDate","phylumName",
    "className","orderName","familyName")]
  empty_cols<- c(paste0("c",12:17))
  x[,empty_cols]<- NA
  x<- x[, c(1:6,12:17,7:11)]

  # Fix column names
  base::colnames(x)<- c("internalTaxonId", "CommonName", "ScientificName",
    "TaxonomicGroup_KBA_dataForm", "GlobalRedListCategory", "AssessAgainstA1c_A1d",
    "AssessmentParameter", "Source", "DerivationOfEstimate", "SourceOfData",
    "Range_Restricted", "Eco_BioRestricted","YearOfSiteValues","phylum",
    "class","order","family")

  #Fix values
  x[,4]<- base::ifelse(x[,4] %in% c("GASTROPODA", "CEPHALOPODA", "BIVALVIA"), "Molluscs",
    base::ifelse(x[,4] == "INSECTA", "Insects",
      base::ifelse(x[,4] == "AVES", "Birds",
        base::ifelse(x[,4] == "REPTILIA", "Reptiles",
          base::ifelse(x[,4] == "MAMMALIA", "Mammals",
            base::ifelse(x[,4] == "ARACHNIDA", "Arachnids",
              base::ifelse(x[,4] == "AMPHIBIA", "Amphibians",
                base::ifelse(x[,4] %in% c("ACTINOPTERYGII", "CEPHALASPIDOMORPHI",
                  "CHONDRICHTHYES", "SARCOPTERYGII","MYXINI"), "Fish",
                  base::ifelse(x[,4] %in% c("PINOPSIDA", "LILIOPSIDA", "BRYOPSIDA",
                    "MAGNOLIOPSIDA","LYCOPODIOPSIDA","POLYPODIOPSIDA", "GINKGOOPSIDA",
                    "GNETOPSIDA","CYCADOPSIDA", "TAKAKIOPSIDA","SPHAGNOPSIDA",
                    "FLORIDEOPHYCEAE","JUNGERMANNIOPSIDA", "MARCHANTIOPSIDA",
                    "CHAROPHYACEAE", "ULVOPHYCEAE", "CHLOROPHYCEAE",
                    "ANTHOCEROTOPSIDA"), "Plants",
                    base::ifelse(x[,4] %in% c("AGARICOMYCETES", "LECANOROMYCETES",
                      "SORDARIOMYCETES", "PEZIZOMYCETES"),"Fungi",
                      base::ifelse(x[,4] %in% c("MALACOSTRACA", "OSTRACODA",
                        "MAXILLOPODA","BRANCHIOPODA"),"Crustacea",
                        base::ifelse(x[,4] == "ANTHOZOA", "Corals",
                          base::ifelse(x[,4] %in% c("HOLOTHUROIDEA", "DIPLOPODA",
                            "CHILOPODA", "HYDROZOA", "ENOPLA","CLITELLATA",
                            "POLYCHAETA", "ECHINOIDEA", "ONYCHOPHORA", "TURBELLARIA",                                               "ENTOGNATHA"), "Other invertebrates",
                            base::ifelse(x[,4] %in% c("PHAEOPHYCEAE"),"Other",
                              "Other"))))))))))))))


  x$GlobalRedListCategory<- base::ifelse(x[,5] == "Endangered", "Endangered (EN)",
    base::ifelse(x[,5] == "Least Concern", "Least Concern (LC)",
      base::ifelse(x[,5] == "Data Deficient", "Data Deficient (DD)",
        base::ifelse(x[,5] == "Critically Endangered", "Critically Endangered (CR)",
          base::ifelse(x[,5] == "Vulnerable", "Vulnerable (VU)",
            base::ifelse(x[,5] == "Near Threatened", "Near Threatened (NT)",
              base::ifelse(x[,5] %in% c("Unknown", NA), "Not assessed", "Old or Extinct")))))))


  x$AssessmentParameter<- "(iv) range"

  x$AssessAgainstA1c_A1d<- base::ifelse(stringr::str_detect(x[,6],
    base::paste(c("A.*2.*", "A.*1.*", "A.*3.*", "A.*4.*"),collapse = '|')),
    base::ifelse(stringr::str_detect(x[,6], base::paste(c("B.*", "C.*","D.*"),
      collapse = '|')),"No",
      base::ifelse(!stringr::str_detect(x[,6],base::paste(c("A.*2.*", "A.*1.*", "A.*4.*"),
        collapse = '|')),"No","Yes")),"No")

  x$Source<- "IUCN SIS database"

  x$DerivationOfEstimate<- "Estimated from mapping"

  x$SourceOfData<- "IUCN SIS database"

  x$YearOfSiteValues<- base::gsub("-.*", "", x$YearOfSiteValues)

  x$phylum<- base::paste(base::toupper(base::substr(x$phylum, 1, 1)),
                         base::tolower(base::substr(x$phylum, 2,
                        base::nchar(x$phylum))), sep="")

  x$class<- base::paste(base::toupper(base::substr(x$class, 1, 1)),
                        base::tolower(base::substr(x$class, 2,
                        base::nchar(x$class))), sep="")

  x$order<- base::paste(base::toupper(base::substr(x$order, 1, 1)),
                        base::tolower(base::substr(x$order, 2,
                        base::nchar(x$order))), sep="")

  x$family<- base::paste(base::toupper(base::substr(x$family, 1, 1)),
                         base::tolower(base::substr(x$family, 2,
                        base::nchar(x$family))), sep="")

  return(x)
}

