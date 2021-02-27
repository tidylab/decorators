devtools::check(remote = TRUE, manual = TRUE)

rhub::check( platform="windows-x86_64-devel", env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = "always") )

devtools::check_win_devel()

devtools::build_manual()

devtools::spell_check()

utils::maintainer(pkgload::pkg_name())
