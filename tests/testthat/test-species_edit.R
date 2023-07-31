

test_that("range_maps 1", {
  x<- KBAscope::species[1:4,]
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  info<- species_info(x,name="SCI_NAME", red_list=TRUE,
                      taxonomy_info=RL)
  
  base::dir.create(file.path(testthat::test_path(),
    "input/species/terrestrial1/range_maps/"),showWarnings = FALSE,
     recursive = TRUE)
  
  
  species_edit(x,type= "range_maps",name="SCI_NAME",
               species_info=info,system="terrestrial1")
  
  expect_warning(expect_warning(expect_snapshot_file(testthat::test_path(),"input/species/terrestrial1/range_maps/A1.gpkg")))
  unlink(base::paste0(testthat::test_path(),"/input"), recursive = TRUE)
  unlink(base::paste0(testthat::test_path(),"/input/species/terrestrial1/range_maps/A1.gpkg"),
         recursive = TRUE)
})

test_that("range_maps 2", {
  x<- KBAscope::species[1:2,]
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  info<- species_info(x,name="SCI_NAME", red_list=TRUE,
                      taxonomy_info=RL)
  
  base::dir.create(file.path(getwd(),
                             "input/species/terrestrial2/range_maps/"),showWarnings = FALSE,
                   recursive = TRUE)
  
  
  species_edit(x,type= "range_maps",name="SCI_NAME",
               species_info=info,system="terrestrial2")
  
  expect_warning(expect_warning(expect_snapshot_file(getwd(),"input/species/terrestrial2/range_maps/A2.gpkg")))
  unlink(base::paste0(getwd(),"/input"), recursive = TRUE)
  unlink(base::paste0(getwd(),"/input/species/terrestrial2/range_maps/A2.gpkg"),
         recursive = TRUE)
})

test_that("range_maps 3", {
  x<- KBAscope::species[5,]
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  info<- species_info(x,name="SCI_NAME", red_list=TRUE,
                      taxonomy_info=RL)
  
  base::dir.create(file.path(getwd(),
                             "input/species/terrestrial3/range_maps/"),showWarnings = FALSE,
                   recursive = TRUE)
  
  
  species_edit(x,type= "range_maps",name="SCI_NAME",
               species_info=info,system="terrestrial3")
  
  expect_warning(expect_warning(expect_snapshot_file(getwd(),"input/species/terrestrial3/range_maps/A3.gpkg")))
  unlink(base::paste0(getwd(),"/input"), recursive = TRUE)
  unlink(base::paste0(getwd(),"/input/species/terrestrial3/range_maps/A3.gpkg"),
         recursive = TRUE)
})

test_that("AOO", {
  x<- KBAscope::species[1:4,]
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  info<- species_info(x,name="SCI_NAME", red_list=TRUE,
                      taxonomy_info=RL)
  
  base::dir.create(file.path(getwd(),"input/species/terrestrial/AOO/"),showWarnings = FALSE,
    recursive = TRUE)
  
  
  species_edit(x,type= "AOO",name="SCI_NAME",
               species_info=info,system="terrestrial")
  
  expect_warning(expect_warning(expect_snapshot_file(getwd(),"input/species/terrestrial/AOO/A.gpkg")))
  unlink(base::paste0(getwd(),"/input"), recursive = TRUE)
  unlink(base::paste0(getwd(),"/input/species/terrestrial/AOO/A.gpkg"),
         recursive = TRUE)
})

test_that("AOH", {
  x<- KBAscope::species[1:4,]
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  info<- species_info(x,name="SCI_NAME", red_list=TRUE,
                      taxonomy_info=RL)
  
  base::dir.create(file.path(getwd(),"input/species/terrestrial/AOH/"),showWarnings = FALSE,
                   recursive = TRUE)
  
  
  species_edit(x,type= "AOH",name="SCI_NAME",
               species_info=info,system="terrestrial")
  
  expect_warning(expect_warning(expect_snapshot_file(getwd(),"input/species/terrestrial/AOH/A.gpkg")))
  unlink(base::paste0(getwd(),"/input"), recursive = TRUE)
  unlink(base::paste0(getwd(),"/input/species/terrestrial/AOH/A.gpkg"),
         recursive = TRUE)
})


test_that("localities", {
  x<- KBAscope::species[1:4,]
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  info<- species_info(x,name="SCI_NAME", red_list=TRUE,
                      taxonomy_info=RL)
  
  base::dir.create(file.path(getwd(),
    "input/species/terrestrial/localities/"),showWarnings = FALSE,
    recursive = TRUE)
  
  
  species_edit(x,type= "localities",name="SCI_NAME",
               species_info=info,system="terrestrial")
  
  expect_warning(expect_warning(expect_snapshot_file(getwd(),"input/species/terrestrial/localities/A.gpkg")))
  unlink(base::paste0(getwd(),"/input"), recursive = TRUE)
  unlink(base::paste0(getwd(),"/input/species/terrestrial/localities/A.gpkg"),
         recursive = TRUE)
})


