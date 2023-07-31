
test_that("id NA", {
  expect_equal(names(spatial_units_edit(spatial_units,id=NA)), 
               c("SiteID","geom"))
})

test_that("id not NA", {
    expect_equal(names(spatial_units_edit(spatial_units,id="id")), 
                 c("SiteID","geom"))
})