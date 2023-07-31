

test_that("input is an object sf and data frame", {
  x<- KBAscope::species
  expect_equal(class(x),c("sf", "data.frame"))

})

test_that("KBA Criteria column created", {
  x<- data.frame(scientificName= "speciesX", GlobalRedListCategory= "Vulnerable (VU)",
                 AssessAgainstA1c_A1d= "Yes", proportion= 0.3,
                 Criterion_A1="A1d",Criterion_B1="B1",
                 Criterion_B2="B2",Criterion_B3="B3",
                 Criterion_D1="D1",Criterion_D2="D2",Criterion_D3="D3")
  expect_true(unique("Criteria" %in% names(criteria(x))))
})


