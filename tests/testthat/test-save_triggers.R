test_that("input is an object sf and data frame", {
  x<- KBAscope::species
  expect_equal(class(x),c("sf", "data.frame"))

})
