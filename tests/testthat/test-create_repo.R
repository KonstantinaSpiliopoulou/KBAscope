test_that("directory does not end in /", {
  x<- "C:/projects/KBA_scoping_analysis"
  expect_true(base::substring(x,nchar(x))!= "/")

})

