# utilities ---------------------------------------------------------------
line_break <- function() paste0("\n", paste0(rep("#", 80), collapse = ""))
banner <- function(title) paste0(line_break(), paste0("\n## ", title), line_break(), "\n", collapse = "")


# testthat ----------------------------------------------------------------
expect_class <- function(object, class) testthat::expect(any(base::class(object) %in% class), "object is" %+% base::class(object) %+% "not" %+% class)
expect_not_failure <- purrr::partial(testthat::expect_type, type = "environment")

