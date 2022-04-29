#' Display a list of package names.
#'
#' @param type \code{"installed"} (default) or \code{"cran"}.
#'
#' @importFrom tools CRAN_package_db
#' @importFrom utils installed.packages
#'
#' @export
#'
#' @details
#' \describe{
#' \item{\code{type}}{If \code{"installed"}, a package list is obtained from your PC. If \code{"cran"}, a package list is obtained from CRAN.}
#' }
#'
#' @examples
#' \dontrun{
#' wordle_list()
#' }

wordle_list <- function(type = "installed") {

  if (type == "installed") {
    pkg_list <- rownames(installed.packages())
    pkg_list <- pkg_list[nchar(pkg_list) == 5]
    pkg_list <- pkg_list[!grepl("[0-9]", pkg_list)]
    print(pkg_list)
    cat(length(pkg_list), "package names retrieved.")
  } else if (type == "cran") {
    cat("Getting package list from CRAN now...\n")
    pkg_list <- CRAN_package_db()[, c("Package")]
    pkg_list <- pkg_list[nchar(pkg_list) == 5]
    pkg_list <- pkg_list[!grepl("[0-9]", pkg_list)]
    print(pkg_list, max = 10000)
    cat(length(pkg_list), "package names retrieved.")
  }

}
