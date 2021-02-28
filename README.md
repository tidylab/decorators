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
