test_that("input is an object sf and data frame", {
  y<- KBAscope::species
  expect_equal(class(y),c("sf", "data.frame"))
})


test_that("pic created", {
  expect_warning(view_results(x=triggers_gis,y=triggers_gis[1:10,]))
  expect_warning(expect_snapshot_file(getwd(),"/view_results.png"))
  unlink(paste0(getwd(),"/view_results/view_results.png"), recursive = TRUE)
  unlink(paste0(getwd(),"/view_results.png"), recursive = TRUE)
})