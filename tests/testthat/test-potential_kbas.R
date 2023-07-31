
test_that("output created", {
  x<- base::paste0(getwd(),"/tests/")
  base::dir.create(file.path(x,"/output/terrestrial/range_maps/"),showWarnings = FALSE,
                   recursive = TRUE)
  base::dir.create(file.path(x,"/results/terrestrial/"),showWarnings = FALSE,
                   recursive = TRUE)
  sf::st_write(triggers_gis[1,],paste0(x,"/output/terrestrial/range_maps/",
    base::unique(triggers_gis[1,]$ScientificName), ".gpkg"), stringsAsFactors=FALSE)
  
  expect_warning(potential_kbas(x,system="terrestrial", output=".gpkg"))
  
  expect_warning(expect_snapshot_file(getwd(),"/potential_KBAs.gpkg"))
  unlink(paste0(getwd(),"/potential_KBAs.gpkg"), recursive = TRUE)
  unlink(paste0(getwd(),"//potential_KBAs.gpkg"), recursive = TRUE)
  
  expect_warning(expect_snapshot_file(getwd(),"/ptrigger_species.gpkg"))
  unlink(paste0(getwd(),"/ptrigger_species.gpkg"), recursive = TRUE)
  unlink(paste0(getwd(),"//ptrigger_species.gpkg"), recursive = TRUE)
  
  unlink(x, recursive = TRUE)
})

#test_that("output created", {
#  x<- base::paste0(getwd(),"/tests/")
#  base::dir.create(file.path(x,"/output/terrestrial/range_maps/"),showWarnings = FALSE,
#                   recursive = TRUE)
#  base::dir.create(file.path(x,"/results/terrestrial/"),showWarnings = FALSE,
#                   recursive = TRUE)
#  temp<- triggers_gis[1,] %>% sf::st_cast("POLYGON") %>% 
#    sf::st_cast("GEOMETRYCOLLECTION")
#  sf::st_write(temp,paste0(x,"/output/terrestrial/range_maps/",
#                                       base::unique(triggers_gis[1,]$ScientificName), "#.gpkg"), stringsAsFactors=FALSE)
#  
#  potential_kbas(x,system="terrestrial", output=".gpkg")
  
# expect_snapshot_file(getwd(),"/potential_KBAs.gpkg")
#  unlink(paste0(getwd(),"/potential_KBAs.gpkg"), recursive = TRUE)
#  unlink(paste0(getwd(),"//potential_KBAs.gpkg"), recursive = TRUE)
#  
#  expect_snapshot_file(getwd(),"/ptrigger_species.gpkg")
#  unlink(paste0(getwd(),"/ptrigger_species.gpkg"), recursive = TRUE)
#  unlink(paste0(getwd(),"//ptrigger_species.gpkg"), recursive = TRUE)
#  
#  unlink(x, recursive = TRUE)
#})

  