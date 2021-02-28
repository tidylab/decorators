# Setup -------------------------------------------------------------------
Customer <<- function(given = NA_character_, family = NA_character_)
    return(data.frame(given = given, family = family))
Runner <<- function(customer = Customer(), birth_date = NA_Date_, start_time = NA_POSIXct_)
    return(cbind(customer, data.frame(birth_date = birth_date, start_time)))


# Tests -------------------------------------------------------------------
describe("decorating a ValueObject with validate_input adds data type validation", {
    it("built-in NA types", {
        expect_s3_class(Customer(given = "Bilbo", family = 888), "data.frame")
        expect_type(Customer <- validate_input(Customer), "closure")
        expect_error(Customer(given = "Bilbo", family = 888), "family")
    })

    it("built-in NA types", {
        athlete <- Customer(given = "Usain", family = "Bolt")
        expect_s3_class(Runner(athlete), "data.frame")
        expect_type(Runner <- validate_input(Runner), "closure")
        expect_s3_class(Runner(), "data.frame")
        # expect_s3_class(Runner(athlete), "data.frame")
        expect_s3_class(Runner(athlete, birth_date = Sys.Date(), start_time = Sys.time()), "data.frame")

        expect_error(Runner(athlete, birth_date = "xxx", start_time = Sys.time()), "birth_date")
        expect_error(Runner(athlete, birth_date = Sys.Date(), start_time = "xxx"), "start_time")
    })
})
