.onAttach <- function(lib, pkg,...){#nocov start
    # options(
    #     usethis.quiet = TRUE
    # )

    if(interactive()) packageStartupMessage(paste(
        "\n\033[44m\033[37m",
        "\nWelcome to decorators",
        "\nMore information, vignettes, and guides are available on the decorators project website:",
        "\nhttps://tidylab.github.io/decorators/",
        "\n\033[39m\033[49m",
        sep = "")
    )

}#nocov end
