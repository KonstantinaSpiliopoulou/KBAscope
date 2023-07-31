
test_that("Red list true", {
  x<- KBAscope::species %>% dplyr::mutate(ScientificName=SCI_NAME)
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  
  expect_true(unique(c("TaxonomicGroup","rr_size",
                       "B2_RR") %in% names(species_info(x,name="ScientificName",
                                                        taxonomy_info=RL))))
})

test_that("Red list false", {
  x<- KBAscope::species %>% dplyr::mutate(ScientificName=SCI_NAME)
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  
  expect_true(unique(c("TaxonomicGroup","rr_size",
          "B2_RR") %in% names(species_info(x,name="ScientificName",red_list=FALSE, 
                                           taxonomy_info=RL))))
})

test_that("TaxonomicGroup NA", {
  x<- KBAscope::species %>% dplyr::mutate(ScientificName="D")
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  
  expect_true(unique(c("TaxonomicGroup","rr_size",
                       "B2_RR") %in% names(species_info(x,name="ScientificName",red_list=TRUE, 
                                                        taxonomy_info=RL))))
})

test_that("TaxonomicGroup not NA", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName="B")
  RL<- KBAscope::red_list_info(taxonomy, assessment, common_names)
  
  expect_true(unique(c("TaxonomicGroup","rr_size",
                       "B2_RR") %in% names(species_info(x,name="ScientificName",red_list=TRUE, 
                                                        taxonomy_info=RL))))
})