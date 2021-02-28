#' @title Measure Execution Time of Functions
#' @description Wrap a function with a timer.
#' @param func (`function`) A function to decorate.
#' @param units (`character`) Units in which the results are desired, including:
#'   \code{"auto"}, \code{"secs"}, \code{"mins"}, \code{"hours"}, \code{"days"},
#'   and \code{"weeks"}. See \link[base]{difftime}.
#' @param digits (`integer`) The number of significant digits to be used. See
#'   \link[base]{signif}.
#' @return (`closure`) An object that contains the original function bound to the environment of the decorator.
#' @references
#' * \href{https://docs.python.org/3/library/timeit.html}{timeit Python module}
#' * \href{http://adv-r.had.co.nz/Functional-programming.html}{Closures in R}
#' @family misc decorators
#' @export
#' @examples
#' Sys.sleep <- time_it(base::Sys.sleep)
#' Sys.sleep(0.1)
time_it <- function(func, units = "auto", digits = 2){
    wrapper <- function(...){
        start_time <- Sys.time()
        output <- withVisible(func(...))
        end_time <- Sys.time()

        print(signif(difftime(end_time, start_time, units = units)), digits = digits)
        ifelse(output$visible, return(output$value), return(invisible(output$value)))
    }

    return(wrapper)
}
