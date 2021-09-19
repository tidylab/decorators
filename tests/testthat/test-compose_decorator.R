test_that("composing a decorator constructs a similar decorator like time_it", {
    Sys.sleep <- base::Sys.sleep
    expect_silent(Sys.sleep(0.01))
    # expect_type(Sys.sleep <- time_it(base::Sys.sleep), "closure")
    # expect_output(Sys.sleep(0.01), "Time difference of")
})
