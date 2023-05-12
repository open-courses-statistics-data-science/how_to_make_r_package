test_that("string_df produces a dataframe", {
  x <- "a,b,c"
  df <- string_df(x, ",")
  expect_equal(nrow(df), 3)
  expect_equal(ncol(df), 2)
})
