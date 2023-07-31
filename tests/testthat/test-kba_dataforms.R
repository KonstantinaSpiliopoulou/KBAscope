test_that("Excel created", {
  
  x<- KBAscope::triggers_gis %>% sf::st_drop_geometry()
  
  #expect_error(
    kba_dataforms(x)#)
  
  expect_warning(expect_warning(expect_snapshot_file(getwd(),"/results/KBA_DataForm.xlsx")))
  unlink(paste0(getwd(),"/results/KBA_DataForm.xlsx"), recursive = TRUE)
})