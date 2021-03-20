# `decorators` <img src="https://raw.githubusercontent.com/tidylab/decorators/master/pkgdown/logo.png" align="right" height="75"/>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/decorators)](https://CRAN.R-project.org/package=decorators)
[![R build
status](https://github.com/tidylab/decorators/workflows/R-CMD-check/badge.svg)](https://github.com/tidylab/decorators/actions)
[![codecov](https://codecov.io/gh/tidylab/decorators/branch/master/graph/badge.svg?token=U6FL5N32FL)](https://codecov.io/gh/tidylab/decorators)

<!-- badges: end -->

A ***decorator*** is a function that receives a function, extends its
behaviour, and returned the altered function. Any caller that uses the
decorated function uses the same interface as it were the original,
undecorated function.

## Examples

The `decorators` package includes decorators:

### `time_it` decorator

    # Running the original Sys.sleep() produces no output
    Sys.sleep(0.1)

    # Decorating the Sys.sleep() with time_it() measures Sys.sleep() execution time 
    # and outputs the measurement   
    Sys.sleep <- decorators::time_it(base::Sys.sleep)
    Sys.sleep(0.1)
    #> Time difference of 0.1 secs

### `validate_arguments` decorator

    ## Define a functions that averages two numbers
    average_two_numbers <- function(a = NA_real_, b = NA_real_) mean(c(a, b))

    ## Before: Averaging two nun-numeric values returns NA and prompts a warning
    average_two_numbers(a = "1", b = "2")
    #> [1] NA

    ## Decorating average_two_numbers() with validate_arguments() checks input types
    average_two_numbers <- decorators::validate_arguments(average_two_numbers)

    ## After: Averaging two nun-numeric prompts an informative error
    average_two_numbers(a = "1", b = "2")

    #> Error in average_two_numbers(a = "1", b = "2") : 
    #>   a is of type `character` rather than `numeric`!

## Installation

You can install the released version of `decorators` from CRAN with:

    install.packages("decorators")

And the development version from GitHub with:

    # install.packages("devtools")
    devtools::install_github("tidylab/decorators")
