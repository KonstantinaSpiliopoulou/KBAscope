test_that("new columns added", {
  x<- data.frame(internalTaxonId='1',name="a",scientificName.x="a",className=NA,redlistCategory=NA,
                 redlistCriteria=NA,assessmentDate=NA,phylumName=NA,className=NA,orderName=NA,
                 familyName=NA,genusName=NA)

  expect_true(unique(c("internalTaxonId","name","scientificName.x","className","redlistCategory","redlistCriteria",
                       "assessmentDate","phylumName","className","orderName","familyName","genusName") %in% names(x)))
})
