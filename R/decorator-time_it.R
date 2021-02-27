#' @title Measure Execution Time of Functions
#' @description Wrap a function with a timer.
#' @param func (`function`) A function.
#' @return (`closure`) An object that contains the original function bound to the environment of the decorator.
#' @references
#' * \href{https://docs.python.org/3/library/timeit.html}{timeit Python module}
#' * \href{http://adv-r.had.co.nz/Functional-programming.html}{Closures in R}
#' @family misc decorators
#' @export
#' @examples
#' Sys.sleep <- time_it(base::Sys.sleep)
#' Sys.sleep(0.01)
time_it <- function(func){
    wrapper <- function(...){
        start_time <- Sys.time()
        output <- withVisible(func(...))
        end_time <- Sys.time()

        print(difftime(end_time, start_time))
        ifelse(output$visible, return(output$value), return(invisible(output$value)))
    }

    return(wrapper)
}
