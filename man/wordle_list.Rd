% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wordle_list.R
\name{wordle_list}
\alias{wordle_list}
\title{Display a list of package names.}
\usage{
wordle_list(type = "installed")
}
\arguments{
\item{type}{\code{"installed"} (default), \code{"cran"}, or \code{"ranking"}.}
}
\description{
Display a list of package names.
}
\details{
\describe{
\item{\code{type}}{If \code{"installed"}, a package list is obtained from your PC. If \code{"cran"}, a package list is obtained from CRAN. If \code{"ranking"}, a top downloaded package list is obtained from CRAN mirror using \{cranlogs\} package.}
}
}
\examples{
\dontrun{
wordle_list()
}
}
