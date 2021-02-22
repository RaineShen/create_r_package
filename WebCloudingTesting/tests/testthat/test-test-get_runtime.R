test_that("correct runtime output", {
  
  op1 <- get_runtime('water', 'movie')
  expect_is(op1, 'data.frame')
  expect_equal(ncol(op1), 4)
  expect_is(op1$Year, 'double')
  expect_equal(colnames(op1)[1] , 'Title')
  expect_equal(get_runtime('black water'), get_runtime('black+water'))
  expect_match(sample(op1[[1]], 1), '*water*', ignore.case = TRUE)
  
})
