test_that("input is an object sf and data frame", {
  y<- KBAscope::species
  expect_equal(class(y),c("sf", "data.frame"))
})


test_that("input is an object data frame", {
  x<- sf::st_drop_geometry(KBAscope::species)
  expect_equal(class(x),"data.frame")
})
