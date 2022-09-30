#' @title Validate the Type of Input Arguments
#' @description Wrap a function with a input validation.
#' @includeRmd vignettes/details/validate_arguments.Rmd
#' @note The original function must have default values of the designated type.
#' @inheritParams time_it
#' @return (`closure`) An object that contains the original function bound to the environment of the decorator.
#' @references
#' * \href{https://pydantic-docs.helpmanual.io/usage/validation_decorator/}{Similar Python module}
#' * \href{http://adv-r.had.co.nz/Functional-programming.html}{Closures in R}
#' @family defensive programming
#' @importFrom methods is
#' @export
#' @examples
#' Car <- function(model = NA_character_, hp = NA_real_){
#'     return(data.frame(model = model, hp = hp))
#' }
#'
#' Car <- validate_arguments(Car)
#' try(Car(model = 555, hp = 120)) # fails because model is numeric rather than character
#'
validate_arguments <- function(func){
    args_expected <- .extract_name_and_type(args = formals(func))

    wrapper <- function(...){
        args_actual <- .extract_name_and_type(args = list(...))

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


# Helpers -----------------------------------------------------------------
.extract_name_and_type <- function(args){
    dict <- data.frame(name = NA_character_, type = NA_character_)[0,]

    for(i in seq_along(args)){ # handle Value-Objects
        if(is(args[[i]], "call")){
            null_value <- eval(args[[i]])
            if(!is(null_value, "list")) null_value <- as.list(null_value)
            new_entery <- .extract_name_and_type(null_value)

        } else if (is(args[[i]], "name")) { # handle type extensions
            type <- gsub("NA_|_$", "", as.character(args[[i]]))
            new_entery <- data.frame(name = names(args)[i], type = type)

        } else { # handle built-in types
            new_entery <- data.frame(name = names(args)[i], type = class(args[[i]])[1])
        }# end if-else

        dict <- rbind(dict, new_entery)
    }# end for-loop

    return(dict)
}
