test_that("directory does not end in /", {
  x<- "C:/projects/KBA_scoping_analysis"
  expect_true(base::substring(x,nchar(x))!= "/")

})

test_that("check that direstories are created", {
  x<- getwd()
  expect_snapshot(cat(snapshot_accept(create_repo(x),
    "Ready to place files for KBA scoping analysis in the right folder!!")))
  
  unlink(paste0(getwd(),"/input"), recursive = TRUE)
  unlink(paste0(getwd(),"/output"), recursive = TRUE)
  unlink(paste0(getwd(),"/results"), recursive = TRUE)
  })


