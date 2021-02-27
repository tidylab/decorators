# time_it -----------------------------------------------------------------
test_that("decorating a function with time_it extends another function abilities", {
    expect_silent(Sys.sleep(0.01))
    expect_type(Sys.sleep <- time_it(base::Sys.sleep), "closure")
    expect_output(Sys.sleep(0.01), "Time difference of")
})
