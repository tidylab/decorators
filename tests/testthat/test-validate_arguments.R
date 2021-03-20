# Setup -------------------------------------------------------------------
Customer <<- function(given = NA_character_, family = NA_character_)
    return(data.frame(given = given, family = family))

WorldRecord <<- function(date = NA_Date_, start_time = NA_POSIXct_, end_time = start_time)
    return(data.frame(date = date, start_time = start_time, end_time = end_time))

Runner <<- function(customer = Customer(), birth_date = NA_Date_, start_time = NA_POSIXct_)
    return(cbind(customer, data.frame(birth_date = birth_date, start_time)))


# Tests -------------------------------------------------------------------
describe("decorating a ValueObject with validate_arguments adds data type validation", {
    it("built-in NA types", {
        expect_s3_class(Customer(given = "Bilbo", family = 888), "data.frame")
        expect_type(Customer <- validate_arguments(Customer), "closure")
        expect_error(Customer(given = "Bilbo", family = 888), "family")
    })

    it("built-in NA types", {
        expect_type(WorldRecord <- validate_arguments(WorldRecord), "closure")
        expect_s3_class(WorldRecord(date = Sys.Date(), start_time = Sys.time()), "data.frame")
        expect_error(WorldRecord(date = Sys.Date(), start_time = "xxx"), "start_time")
    })

    it("nested value object", {
        athlete <- Customer(given = "Usain", family = "Bolt")
        expect_s3_class(Runner(athlete), "data.frame")
        expect_type(Runner <- validate_arguments(Runner), "closure")
        expect_s3_class(Runner(), "data.frame")
        # expect_s3_class(Runner(athlete), "data.frame")
        expect_s3_class(Runner(athlete, birth_date = Sys.Date(), start_time = Sys.time()), "data.frame")

        expect_error(Runner(athlete, birth_date = "xxx", start_time = Sys.time()), "birth_date")
        expect_error(Runner(athlete, birth_date = Sys.Date(), start_time = "xxx"), "start_time")
    })
})

describe("decorating a function with validate_arguments adds data type validation", {
    it("built-in NA types", {
        average_two_numbers <- function(a = NA_real_, b = NA_real_) mean(c(a, b))
        expect_type(average_two_numbers <- decorators::validate_arguments(average_two_numbers), "closure")
        expect_error(average_two_numbers(a = "1", b = "2"), "character")
    })
})
