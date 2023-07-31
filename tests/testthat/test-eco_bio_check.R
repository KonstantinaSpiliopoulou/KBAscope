test_that("input is an object sf and data frame", {
  x<- KBAscope::species
  expect_equal(class(x),c("sf", "data.frame"))
})



test_that("Case 1: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName=SCI_NAME, TaxonomicGroup="sth")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                        ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))
})

test_that("Case 2: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="A") %>%
    dplyr::mutate(ScientificName=SCI_NAME, TaxonomicGroup="sth")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                        ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))
})

test_that("Case 3: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="A") %>%
    dplyr::mutate(ScientificName=SCI_NAME, TaxonomicGroup="Actinopterygii")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                      bioregion= KBAscope::ecoregion,bio_name="ECO_NAME")))))
})


test_that("Case 4: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="C") %>%
    dplyr::mutate(ScientificName=SCI_NAME, TaxonomicGroup="sth")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                                                                ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))
})


test_that("Case 5: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName="Eisenia anzac", TaxonomicGroup="Clitellata")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x)))))
})

test_that("Case 6: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName=SCI_NAME, TaxonomicGroup="Actinopterygii")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                                                                ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))
})

test_that("Case 7: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName="Helodrilus hachiojii", TaxonomicGroup="sth")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                                                                ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))  
})


test_that("Case 8: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName="Panulirus brunneiflagellum", TaxonomicGroup="sth")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                                                                ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))  
})

test_that("Case 9: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName="Scaphirhynchus suttkusi", TaxonomicGroup="sth")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                                                                ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))  
})



test_that("Case 10: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName="Albula koreana", TaxonomicGroup="sth")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                                                                ecoregion= KBAscope::ecoregion,eco_name="ECO_NAME")))))  
})



test_that("Case 11: Eco_BioRestricted, Eco_BioName and Eco_bio_list columns created", {
  x<- KBAscope::species %>% dplyr::filter(SCI_NAME=="B") %>%
    dplyr::mutate(ScientificName=SCI_NAME, TaxonomicGroup="Actinopterygii")
  expect_true(unique(c("Eco_BioRestricted","Eco_bio_list",
                       "Eco_BioName") %in% names((eco_bio_check(x, 
                                                                bioregion= KBAscope::ecoregion,bio_name="ECO_NAME")))))
})

