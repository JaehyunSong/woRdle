#' Plotting your guesses and remaining keys
#'
#' @param x a data.frame
#' @param y a data.frame
#'
#' @importFrom magrittr `%>%`
#' @importFrom dplyr mutate
#' @importFrom dplyr bind_rows
#' @importFrom forcats fct_inorder
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_tile
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 geom_text
#' @importFrom ggplot2 scale_fill_manual
#' @importFrom ggplot2 labs
#' @importFrom ggplot2 facet_wrap
#' @importFrom ggplot2 coord_fixed
#' @importFrom ggplot2 theme_minimal
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_text
#' @importFrom ggplot2 element_blank
#'
#' @export
#'
#' @return a \code{ggplot} object
#'
#' @seealso \code{\link{wordle}}
#'
#' @examples
#' \dontrun{
#' plot_wordle(x, y)
#' }

plot_wordle <- function(x, y) {
  Char <- Match1 <- Text_x <- Text_y <- Tile_x <- Tile_y <- Type <- NULL

  result_plot <- bind_rows(list("Your Guess"     = x,
                                "Remaining Keys" = y),
                           .id = "Type") %>%
    mutate(Type = fct_inorder(Type)) %>%
    ggplot() +
    geom_tile(aes(x = Tile_x, y = Tile_y, fill = Match1),
              color = "black", size = 0.75,
              width = 0.9, height = 0.9)  +
    geom_text(aes(x = Text_x, y = Text_y, label = Char),
              color = "white", size = 10) +
    scale_fill_manual(values = c("correct"           = "#6cad64",
                                 "wrong position"    = "#c9b659",
                                 "not in the answer" = "#787c7e",
                                 "?"                 = "gray80")) +
    labs(fill = "") +
    facet_wrap(~Type, ncol = 2) +
    coord_fixed(ratio = 1) +
    theme_minimal(base_size = 16) +
    theme(legend.position = "bottom",
          strip.text.x    = element_text(size = 20),
          plot.title      = element_text(size = 25),
          panel.grid      = element_blank(),
          axis.title      = element_blank(),
          axis.text       = element_blank())

  result_plot
}
