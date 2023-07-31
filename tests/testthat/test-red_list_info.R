
test_that("columns are created", {
  
  expect_true(unique(c("internalTaxonId", "CommonName", "ScientificName",
                       "GlobalRedListCategory", "AssessAgainstA1c_A1d","YearOfSiteValues",
                       "AssessmentParameter", "Source", "DerivationOfEstimate",
                       "SourceOfData","Range_Restricted", "Eco_BioRestricted","phylum",
                       "class","order","family") %in% names(red_list_info(taxonomy,
                                                        assessment, common_names))))
})
