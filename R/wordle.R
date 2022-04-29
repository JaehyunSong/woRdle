#' Play wordle with your R package names.
#'
#' @param answer \code{"installed"}, \code{"cran"}, or an atomic vector of any five character.
#' @param strict a logical value (default is \code{FALSE})
#'
#' @importFrom magrittr `%>%`
#' @importFrom grDevices graphics.off
#' @importFrom utils installed.packages
#' @importFrom dplyr recode
#' @importFrom dplyr case_when
#'
#' @export
#'
#' @details
#' \describe{
#' \item{\code{answer}}{If \code{"installed"}, a package list is obtained from your PC. If \code{"cran"}, a package list is obtained from CRAN. Also, you can set any answer with five characters.}
#' \item{\code{strict}}{If \code{TRUE}, your guess not in package list is not applicable. If \code{FALSE} (default), your guess can have any five characters.}
#' }
#'
#' @examples
#' \dontrun{
#' wordle()
#' }

wordle <- function(answer = "installed", strict = TRUE) {

  graphics.off()

  if (answer == "installed") {
    pkg_list <- rownames(installed.packages())
    pkg_list <- pkg_list[nchar(pkg_list) == 5]
    cat(length(pkg_list), "package names retrieved.")
    ans      <- toupper(sample(pkg_list, 1))
  } else if (answer == "cran") {
    cat("Getting package list from CRAN now...\n")
    pkg_list <- tools::CRAN_package_db()[, c("Package")]
    cat(length(pkg_list), "package names retrieved.")
    pkg_list <- pkg_list[nchar(pkg_list) == 5]
    ans      <- toupper(sample(pkg_list, 1))
  } else {
    if (nchar(answer) == 5) {
      ans      <- toupper(answer)
    } else {
      stop("Answer must have 5 characters.")
    }
  }

  ans2 <- strsplit(ans, "", fixed = TRUE)[[1]]

  result <- data.frame(
    Trial  = rep(1:6, each = 5),
    Tile_x = rep(1:5, 6),
    Tile_y = rep(6:1, each = 5),
    Text_x = rep(1:5, 6),
    Text_y = rep(6:1, each = 5),
    Char   = "",
    Match1 = "?",
    Match2 = -1
  )

  keylist <- data.frame(
    Trial  = rep(1:6, each = 5),
    Tile_x = rep(1:5, 6),
    Tile_y = rep(6:1, each = 5),
    Text_x = rep(1:5, 6),
    Text_y = rep(6:1, each = 5),
    Char   = c(LETTERS, rep("", 4)),
    Match1 = "?",
    Match2 = -1
  )

  result2 <- ""

  print(plot_wordle(result, keylist))

  for(i in 1:6) {

    text <- readline(prompt = paste0("Input your guess (", 7 - i, " times reamined): "))

    if (strict & answer %in% c("installed", "cran")) {
      while (!(text %in% pkg_list) & answer %in% c("installed", "cran")) {
        cat("{", toupper(text), "} is not in pacakge list.\n", sep = "")
        text <- readline(prompt = paste0("Input your guess (", 7 - i, " times reamined): "))
      }
    }


    while (nchar(text) != 5 | !all(strsplit(toupper(text), "")[[1]] %in% LETTERS)) {
      cat("Guess must have 5 characters. (only alphabets)\n")
      text <- readline(prompt = paste0("Input your guess (", 7 - i, " times reamined): "))
    }

    text       <- toupper(text)
    text_split <- strsplit(text, "")[[1]]

    match1 <- text_split == ans2
    match2 <- text_split %in% ans2
    match3 <- match1 + match2
    match4 <- recode(match3,
                     "2" = "correct",
                     "1" = "wrong position",
                     "0" = "not in the answer")
    match5 <- recode(match3,
                     "2" = "\U0001f7e9",
                     "1" = "\U0001f7e8",
                     "0" = "\u2b1b")

    names(match1) <- names(match2) <- names(match3) <- text_split

    result$Char[result$Trial == i]   <- text_split
    result$Match1[result$Trial == i] <- match4

    result2 <- paste0(result2,
                      paste(match5, collapse = ""), "\n")

    for (j in 1:length(unique(text_split))) {
      keylist$Match2[keylist$Char %in% unique(text_split)[j]] <- max(
        keylist$Match2[keylist$Char %in% unique(text_split)[j]],
        match3[unique(text_split)[j]]
      )
    }

    keylist <- keylist %>%
      mutate(Match1 = case_when(Match2 == 2 ~ "correct",
                                Match2 == 1 ~ "wrong position",
                                Match2 == 0 ~ "not in the answer",
                                TRUE        ~ "?"))

    print(plot_wordle(result, keylist))

    if (sum(match3) == 10) {
      cat("Congratulation!!\n")
      cat("My Record: ", i, " (Answer was {", toupper(ans), "})\n", sep = "")
      cat(result2)
      break()
    }

    if (i == 6) {
      cat("My Record: Fail (Answer was {", toupper(ans), "})\n", sep = "")
      cat(result2)
    }

  }

}
