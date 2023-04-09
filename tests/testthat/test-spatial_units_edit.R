test_that("geometry column is named 'geom'", {
  KBAscope::spatial_units
  expect_equal(names(KBAscope::spatial_units[,ncol(KBAscope::spatial_units)]), "geom")
})


