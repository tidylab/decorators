#' @noRd
#' @keywords internal
#' @export
assert <- new.env()


# assert$input_type -------------------------------------------------------
assert$input_type <- function(func){
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
            msg <- paste0(args[i, "name"], " is of type ", args[i, "type.actual"], " rather than ", args[i, "type.expected"], "!")
            stop(msg)
        }

        ifelse(output$visible, return(output$value), return(invisible(output$value)))
    }

    return(wrapper)
}
