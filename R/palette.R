
#' @rdname disco_data
#'
#' @param palette The name of the palette from which to select colors
#' @param n Number of colors selected
#' @param alpha Degree of opacity in [0, 1]
#' @param direction Order of colors (1 = forward, -1 = reverse)
#' @export
#'
disco <- function(palette, n = NULL, alpha = NULL, direction = 1) {

  cols <- disco_palette_data(palette)

  if (is.null(alpha)) {
    pal <- rgb(cols$r, cols$g, cols$b, maxColorValue = 255)
  } else {
    pal <- rgb(cols$r, cols$g, cols$b, alpha = alpha * 255, maxColorValue = 255)
  }

  if (is.null(n)) {
    n <- length(pal)
  } else if (length(pal) < n) {
    warning(paste0("Insufficient number of values in palette '", palette, "'"))
  }

  if (palette %in% c("daybreak", "midnight", "eclipse")) {
    index <- pal9_index(n)
  } else if (palette == "sunset") {
    index <- pal11_index(n)
  } else if (palette == "rainbow") {
    index <- rainbow_index(n)
  } else {  # bright, vibrant, muted, light
    index <- 1:n
  }

  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }
  if (direction == -1) {
    index <- rev(index)
  }

  pal[index]
}

#' @rdname disco_data
#' @keywords internal
#'
disco_palette_names <- function() names(palettes)

#' Retrieve palette by name from palettes list stored in sysdata.rda
#'
#' @rdname disco_data
#' @keywords internal
#'
#' @inheritParams disco
#' @export
#'
disco_palette_data <- function(palette) {
  palette <- match.arg(palette, disco_palette_names())
  palettes[[palette]]
}

#' Retrieve the indices of colors in the 9-length palettes
#' based on the number of selected colors.
#'
#' @keywords internal
#'
#' @param n Number of colors to select
#'
pal9_index <- function(n) {
  switch(as.character(n),
    '1' = c(5),
    '2' = c(3, 7),
    '3' = c(3, 5, 7),
    '4' = c(2, 4, 6, 8),
    '5' = c(1, 3, 5, 7, 9),
    '6' = c(2, 3, 4, 6, 7, 8),
    '7' = c(2, 3, 4, 5, 6, 7, 8),
    '8' = c(1, 2, 3, 4, 6, 7, 8, 9),
    '9' = c(1, 2, 3, 4, 5, 6, 7, 8, 9),
          c(1, 2, 3, 4, 5, 6, 7, 8, 9)
  )
}

#' Retrieve the indices of colors in the 11-length palettes
#' based on the number of colors selected.
#'
#' @keywords internal
#'
#' @param n Number of colors to select
#'
pal11_index <- function(n) {
  switch(as.character(n),
    '1'  = c(6),
    '2'  = c(4, 8),
    '3'  = c(4, 6, 8),
    '4'  = c(3, 5, 7, 9),
    '5'  = c(2, 4, 6, 8, 10),
    '6'  = c(1, 3, 5, 7,  9, 11),
    '7'  = c(1, 3, 5, 6,  7,  9, 11),
    '8'  = c(2, 3, 4, 6,  7,  8,  9, 10),
    '9'  = c(2, 3, 4, 5,  6,  7,  8,  9, 10),
    '10' = c(1, 2, 3, 4,  5,  7,  8,  9, 10, 11),
    '11' = c(1, 2, 3, 4,  5,  6,  7,  8,  9, 10, 11),
           c(1, 2, 3, 4,  5,  6,  7,  8,  9, 10, 11)
  )
}

#' Retrieve the indices of colors in the rainbow palette
#' based on the number of colors selected.
#'
#' @keywords internal
#'
#' @param n Number of colors to select
#'
rainbow_index <- function(n) {
  switch(as.character(n),
    '1'  = c(10),
    '2'  = c(10, 26),
    '3'  = c(10, 18, 26),
    '4'  = c(10, 15, 18, 26),
    '5'  = c(10, 14, 15, 18, 26),
    '6'  = c(10, 14, 15, 17, 18, 26),
    '7'  = c( 9, 10, 14, 15, 17, 18, 26),
    '8'  = c( 9, 10, 14, 15, 17, 18, 23, 26),
    '9'  = c( 9, 10, 14, 15, 17, 18, 23, 26, 28),
    '10' = c( 9, 10, 14, 15, 17, 18, 21, 24, 26, 28),
    '11' = c( 9, 10, 12, 14, 15, 17, 18, 21, 24, 26, 28),
    '12' = c( 3,  6,  9, 10, 12, 14, 15, 17, 18, 21, 24, 26),
    '13' = c( 3,  6,  9, 10, 12, 14, 15, 16, 17, 18, 21, 24, 26),
    '14' = c( 3,  6,  9, 10, 12, 14, 15, 16, 17, 18, 20, 22, 24, 26),
    '15' = c( 3,  6,  9, 10, 12, 14, 15, 16, 17, 18, 20, 22, 24, 26, 28),
    '16' = c( 3,  5,  7,  9, 10, 12, 14, 15, 16, 17, 18, 20, 22, 24, 26, 28),
    '17' = c( 3,  5,  7,  8,  9, 10, 12, 14, 15, 16, 17, 18, 20, 22, 24, 26, 28),
    '18' = c( 3,  5,  7,  8,  9, 10, 12, 14, 15, 16, 17, 18, 20, 22, 24, 26, 27, 28),
    '19' = c( 2,  4,  5,  7,  8,  9, 10, 12, 14, 15, 16, 17, 18, 20, 22, 24, 26, 27, 28),
    '20' = c( 2,  4,  5,  7,  8,  9, 10, 12, 13, 14, 15, 16, 17, 18, 20, 22, 24, 26, 27, 28),
    '21' = c( 2,  4,  5,  7,  8,  9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 21, 23, 25, 26, 27, 28),
    '22' = c( 2,  4,  5,  7,  8,  9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 21, 23, 25, 26, 27, 28, 29),
    '23' = c( 1,  2,  4,  5,  7,  8,  9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 21, 23, 25, 26, 27, 28, 29),
           c( 1,  2,  4,  5,  7,  8,  9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 21, 23, 25, 26, 27, 28, 29)
  )
}

#' Show the different disco palettes
#'
#' This is a simple function to show the selection of palettes
#' available in the `disco` package
#'
#' @param palettes One or more palette names to show
#' @inheritParams disco
#'
#' @importFrom grDevices n2mfrow
#' @importFrom graphics image par
#' @export
#'
#' @examples
#'
#' disco_palette_show()
#'
disco_palette_show <- function(palettes = disco_palette_names(), n = NULL,
                               alpha = NULL, direction = 1) {
  dims <- n2mfrow(length(palettes))
  oldpar <- par(mfrow = dims, mai = par('mai')/3)
  on.exit(par(oldpar))

  for (palette in palettes) {
    pal <- disco(palette, n, alpha, direction)
    x <- 1:length(pal)
    image(x, 1, as.matrix(x),
          col = pal, main = palette, axes = FALSE,
          ylab = "", xaxt = "n", yaxt = "n", bty = "n")
  }
}
