
test_that("KBA criterion A columns created", {
  x<- data.frame(scientificName= "speciesX", GlobalRedListCategory= "Vulnerable (VU)",
                 AssessAgainstA1c_A1d= "Yes", proportion= 0.3)
  expect_true(unique("Criterion_A1" %in% names(criterion_A(x))))
})


test_that("input is an object sf and data frame", {
  x<- KBAscope::species
  expect_equal(class(x),c("sf", "data.frame"))

})

test_that("Information to apply KBA criterion A exists", {
  x<- data.frame(scientificName= "speciesX", GlobalRedListCategory= "Vulnerable (VU)",
                 AssessAgainstA1c_A1d= "Yes", proportion= 0.3)
  expect_true(unique(c("GlobalRedListCategory","AssessAgainstA1c_A1d", "proportion") %in%
                names(x)))
})

