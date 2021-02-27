# assert$input_type -------------------------------------------------------
test_that("decorating a ValueObject with assert$input_type adds data type validation", {
    Customer <- function(given = NA_character_, family = NA_character_){
        data.frame(given = given, family = family)
    }

    expect_s3_class(Customer(given = "Bilbo", family = 888), "data.frame")
    expect_type(Customer <- assert$input_type(Customer), "closure")
    expect_error(Customer(given = "Bilbo", family = 888), "family")
})
