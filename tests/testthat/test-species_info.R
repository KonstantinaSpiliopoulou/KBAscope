test_that("input is a data frame", {
  x<- sf::st_drop_geometry(KBAscope::species)
  expect_equal(class(x),"data.frame")
})


test_that("multiplication works", {
  x<- data.frame(ScientificName="A",ASSESSMENT=1,ID_NO=1,internalTaxonId=NA,
    CommonName=NA,TaxonomicGroup_KBA_dataForm=NA,GlobalRedListCategory=NA,
    AssessAgainstA1c_A1d=NA,AssessmentParameter=NA,Source=NA,DerivationOfEstimate=NA,
    SourceOfData=NA,Range_Restricted=NA,Eco_BioRestricted=NA,YearOfSiteValues=NA,
    phylum=NA,class=NA,order=NA,family=NA,TaxonomicGroup=NA,rr_size=NA,B2_RR=NA)

  expect_true(unique(c("ScientificName","ASSESSMENT","ID_NO","internalTaxonId","CommonName",
                       "TaxonomicGroup_KBA_dataForm","GlobalRedListCategory","AssessAgainstA1c_A1d",
                       "AssessmentParameter","Source","DerivationOfEstimate","SourceOfData",
                       "Range_Restricted","Eco_BioRestricted","YearOfSiteValues","phylum",
                       "class","order","family","TaxonomicGroup","rr_size","B2_RR") %in% names(x)))
})



