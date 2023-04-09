test_that("KBA criterion D columns created", {
  x<- data.frame(SiteID=12,scientificName= "speciesX", GlobalRedListCategory= "Vulnerable (VU)",
                 AssessAgainstA1c_A1d= "Yes", proportion= 0.3)
  expect_true(unique(c("Criterion_D1","Criterion_D2","Criterion_D3") %in% names(criterion_D(x))))
})



test_that("Information to apply KBA criterion D exists", {
  x<- data.frame( proportion= 0.3)
  expect_true(unique("proportion" %in%
                       names(x)))
})
