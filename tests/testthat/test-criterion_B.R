
test_that("KBA criterion B columns created", {
  x<- data.frame(scientificName= "speciesX",TaxonomicGroup= "Mammalia",
      Range_Restricted= "Yes", Eco_BioRestricted= "Yes", proportion= 11.3)
  expect_true(unique(c("Criterion_B1","Criterion_B2",
                       "Criterion_B3") %in% names(criterion_B(x))))
})

test_that("KBA criterion B columns created", {
  x<- data.frame(scientificName= "speciesX",TaxonomicGroup= "NA",
                 Range_Restricted= "Yes", Eco_BioRestricted= "Yes", proportion= 11.3)
  expect_true(unique(c("Criterion_B1","Criterion_B2",
                       "Criterion_B3") %in% names(criterion_B(x))))
})

test_that("input is an object sf and data frame", {
  x<- KBAscope::species
  expect_equal(class(x),c("sf", "data.frame"))

})

test_that("Information to apply KBA criterion B exists", {
  x<- data.frame(scientificName= "speciesX",TaxonomicGroup= "Mammalia",
      Range_Restricted= "Yes", Eco_BioRestricted= "Yes", proportion= 11.3)
  expect_true(unique(c("TaxonomicGroup","Range_Restricted","Eco_BioRestricted",
              "proportion") %in% names(x)))
})
