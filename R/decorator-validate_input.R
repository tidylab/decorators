#' @title Validate the Type of Input Arguments
#' @description Wrap a function with a input validation.
#' @note Original function must have default values of the desired type.
#' @param func (`function`) A function.
#' @return (`closure`) An object that contains the original function bound to the environment of the decorator.
#' @references
#' * \href{https://docs.python.org/3/library/timeit.html}{timeit Python module}
#' * \href{http://adv-r.had.co.nz/Functional-programming.html}{Closures in R}
#' @family defensive programming
#' @export
#' @examples
#' Car <- function(model = NA_character_, hp = NA_real_){
#'     return(data.frame(model = model, hp = hp))
#' }
#'
#' Car <- validate_input(Car)
#' try(Car(model = 555, hp = 120)) # fails because model is numeric rather than character
#'
validate_input <- function(func){
    args_expected <- data.frame()
    for(i in seq_along(formals(func))){
        args_expected[i, "name"] = names(formals(func))[i]
        args_expected[i, "type"] = class(formals(func)[[i]])[1]
    }

    wrapper <- function(...){
        args_actual <- data.frame()
        for(i in seq_along(list(...))){
            args_actual[i, "name"] = names(list(...))[i]
            args_actual[i, "type"] = class(list(...)[[i]])[1]
        }

        args <- merge(args_expected, args_actual, by = "name", suffixes = c(".expected", ".actual"))
        for(i in seq_len(nrow(args))){
            if(identical(args[i, "type.expected"], args[i, "type.actual"])) next
            msg <- paste0(args[i, "name"], " is of type `", args[i, "type.actual"], "` rather than `", args[i, "type.expected"], "`!")
            stop(msg)
        }

        return(func(...))
    }

    return(wrapper)
}
