
#' A discrete scale for the colour aesthetic in ggplot2
#'
#' @rdname ggplot2_scales
#'
#' @param ... Arguments to pass on to `ggplot2::discrete_scale()`
#' @inheritParams disco
#'
#' @return A `ScaleDiscrete` object that can be added to a `ggplot` object
#'
#' @export
scale_colour_disco <- function(..., palette = "bright", alpha = NULL, direction = 1, aesthetics = "colour") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 is required for this functionality", call. = FALSE)
  }
  ggplot2::discrete_scale(aesthetics, "disco", function(n) disco(palette, n, alpha, direction), ...)
}

#' @rdname ggplot2_scales
#' @export
scale_color_disco <- scale_colour_disco

#' A discrete scale for the fill aesthetic in ggplot2
#'
#' @rdname ggplot2_scales
#'
#' @inheritParams disco
#' @inheritParams scale_colour_disco
#'
#' @export
scale_fill_disco <- function(..., palette = "bright", alpha = NULL, direction = 1, aesthetics = "fill") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("ggplot2 is required for this functionality", call. = FALSE)
  }
  ggplot2::discrete_scale(aesthetics, "disco", function(n) disco(palette, n, alpha, direction), ...)
}
