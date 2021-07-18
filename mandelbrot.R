# Mandelbrot Set Function in base R

# TODO: How to paralelize?

mandelbrot <- function (xlim = c(-2, 2), ylim = c(-2, 2), resolution = 100, threshold = 4, iterations = 10) {

  # Function
  .mandelbrot_grid <- function(xlim = c(-2, 2), ylim = c(-2, 2), resolution = 100) {
    v <- seq(-2, 2, length.out=resolution)
    # Create all grid points
    data <- expand.grid(x = v, y = v)
    # Transform to complex numbers
    data$c <- complex(real=data$x, imaginary=data$y)
    data
  }
  # Initialize data
  data <- .mandelbrot_grid(xlim, ylim, resolution)
  data$z <- data$c
  data$n <- 0

  # Iterate
  for (i in 1:iterations) {
    data[[paste0("iter_", i)]] <- sqrt(Re(data$z)^2 + Im(data$z)^2)
    data$n[data[[paste0("iter_", i)]] < threshold] <- i

    data$z <- data$z^2 + data$c
  }
  data
}

# Check against reference
# rez <- mandelbrot(data, resolution = 10, iterations = 10)
# ref <- mandelbrot::mandelbrot0(resolution = 10, iterations = 10)
# merge(ref, rez[c("x", "y", "n")])
# ref  # Some discrepancies, not sure why
