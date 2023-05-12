test_that("strsplit1() splits a string with commas", {
  x <- "a,b,c"
  expect_equal(strsplit1(x, ","), c("a", "b", "c"))
})

test_that("strsplit1() splits a string with hyphens", {
  x <- "a-b-c"
  expect_equal(strsplit1(x, "-"), c("a", "b", "c"))
})
