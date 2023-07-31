test_that("output created", {
  x<- KBAscope::triggers_gis %>% sf::st_drop_geometry()
  y<- getwd()
  
  results_summary(x,path=y)
  
  expect_warning(expect_snapshot_file(getwd(),"/results_summary.xlsx"))
  unlink(paste0(getwd(),"/results_summary.xlsx"), recursive = TRUE)
  unlink(paste0(getwd(),"//results_summary.xlsx"), recursive = TRUE)
})