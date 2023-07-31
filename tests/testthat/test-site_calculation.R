
test_that("range maps", {
  x<- KBAscope::species %>% dplyr::mutate(GlobalRange=10000)
  y<- spatial_units_edit(spatial_units,id="id")
  expect_warning(expect_true(unique(c("SiteRange","proportion") %in% names(site_calculation(x, 
    y,type="range_maps")))))
})

test_that("AOO", {
  x<- KBAscope::species %>% dplyr::mutate(GlobalRange=10000)
  y<- spatial_units_edit(spatial_units,id="id")
  expect_warning(expect_true(unique(c("SiteRange","proportion") %in% names(site_calculation(x, y,type="AOO")))))
})

test_that("AOH", {
  x<- KBAscope::species %>% dplyr::mutate(GlobalRange=10000)
  y<- spatial_units_edit(spatial_units,id="id")
  expect_warning(expect_true(unique(c("SiteRange","proportion") %in% names(site_calculation(x, y,type="AOH")))))
})

test_that("localities", {
  x<- KBAscope::species %>% dplyr::mutate(GlobalRange=10000)
  y<- spatial_units_edit(spatial_units,id="id")
  expect_warning(expect_true(unique(c("SiteRange","proportion") %in% names(site_calculation(x, y,type="localities")))))
})

test_that("population", {
  x<- KBAscope::species %>% dplyr::mutate(Global_min=10000, Site_min=10,
    SiteID=794) %>% sf::st_drop_geometry() 
  y<- spatial_units_edit(spatial_units,id="id")
  expect_message(expect_true("proportion" %in% names(site_calculation(x, y,type="population"))))
})
