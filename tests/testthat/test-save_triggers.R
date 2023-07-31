
test_that("range_maps", {
  x<- KBAscope::species[1,] %>% dplyr::mutate(Criteria="B1", ScientificName=SCI_NAME)
  y<- getwd()
  save_triggers(x,type="range_maps",path=paste0(y,"/"), output=".gpkg")
                                      
  expect_warning(expect_snapshot_file(getwd(),"/A.gpkg"))
  unlink(paste0(getwd(),"/A.gpkg"), recursive = TRUE)
  unlink(paste0(getwd(),"//A.gpkg"), recursive = TRUE)
  })


test_that("population", {
  x<- KBAscope::species[1,] %>% dplyr::mutate(Criteria="B1", ScientificName="B")
  y<- getwd()
  save_triggers(x,type="population",path=paste0(y,"/"), output=".gpkg")
  
  expect_warning(expect_snapshot_file(getwd(),"/B.gpkg"))
  unlink(paste0(getwd(),"/B.gpkg"), recursive = TRUE)
  unlink(paste0(getwd(),"//B.gpkg"), recursive = TRUE)
})

