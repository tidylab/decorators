# `decorators` <img src="https://raw.githubusercontent.com/tidylab/decorators/master/pkgdown/logo.png" align="right" height="75"/>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/decorators)](https://CRAN.R-project.org/package=decorators)
[![R build
status](https://github.com/tidylab/decorators/workflows/R-CMD-check/badge.svg)](https://github.com/tidylab/decorators/actions)
[![codecov](https://codecov.io/gh/tidylab/decorators/branch/master/graph/badge.svg?token=U6FL5N32FL)](https://codecov.io/gh/tidylab/decorators)

<!-- badges: end -->

## Introduction

A decorator is a function that receives a function, extends its
behaviour, and returned the altered function. Any caller that uses the
decorated function uses the same interface as it were the original,
undecorated function. Decorators serve two primary uses: (1) Enhancing
the response of a function as it sends data to a second component; (2)
Supporting multiple optional behaviours. An example of the first use is
a timer decorator that runs a function, outputs its execution time on
the console, and returns the original function’s result. An example of
the second use is input type validation decorator that during running
time tests whether the caller has passed input arguments of a particular
class. Decorators can reduce execution time, say by `memoisation`, or
reduce bugs by adding defensive programming routines.

## Decorators Violate the Single-Responsibility Principle

> Functions should do one thing. They should do it well. They should do
> it only.

The function `sum()` does one thing – summing up a numeric vector.

    base::sum(1, 2, 3)
    #> [1] 6

If the caller passes `sum()` non-numeric values then the function fails.

    base::sum(1, "2", 3)

    #> [1] "Error in base::sum(1, \"2\", 3) : invalid 'type' (character) of argument"

An example of a Single-Responsibility Principle (SRP) violation, happens
when a programmer adds the responsibility of error handling to the `sum`
function:

    # Decorating `sum` with failproof mechanism:
    # 1. Return NA when sum fails
    # 2. Extract the result
    sum <- purrr::safely(base::sum, otherwise = NA_real_)
    sum <- purrr::compose(sum, ~ purrr::pluck(.x, "result"), .dir = "forward") 

With the decorated `sum()` function, the behaviour for non-numeric
values alters

    sum(1, 2, 3)
    #> [1] 6
    sum(1, "2", 3)
    #> [1] NA

The decorated `sum()` function violates Single-Responsibility Principle.
Nevertheless, its failproof quality is desirable in production systems.
This is because:

1.  Production system should be failure safe; and
2.  The decorated function requires no changes in the codebase. Without
    it, a programmer would have encapsulated `sum()` instances with
    `tryCatch` statement such as this:

<!-- -->

    tryCatch(sum(x), error = function(e) return(NA_real_))

## Decorator Defenition

> A decorator is a function that takes another function and extends the
> behavior of the latter function without explicitly modifying it.

Reformulating the definition of a decorator we

1.  A decorator receives a function and returns a function
2.  The original function and the decorated function are called in the
    same way
3.  The decoration alters the behaviour of the original function. The
    behaviour alternation may change:
    -   The execution time of the function;
    -   The returned value/data-structure;
    -   The handling of unusual conditions, including errors and
        warnings. For instance, converting a runtime error into an
        exception;
    -   
    -   A combination of the above.

## Example: `time_it` decorator

    # Running the original Sys.sleep() produces no output
    Sys.sleep(0.1)

    # Decorating the Sys.sleep() with time_it() measures Sys.sleep() execution time 
    # and outputs the measurement   
    Sys.sleep <- decorators::time_it(base::Sys.sleep)
    Sys.sleep(0.1)
    #> Time difference of 0.1 secs

## Installation

You can install the released version of `decorators` from CRAN with:

    install.packages("decorators")

And the development version from GitHub with:

    # install.packages("devtools")
    devtools::install_github("tidylab/decorators")
