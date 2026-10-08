# Verify installed arithmetic against independent rational constants.
example_file <- system.file("examples", "reference.R", package = "gsel",
                            mustWork = TRUE)
env <- new.env(parent = baseenv())
sys.source(example_file, envir = env)
stopifnot(isTRUE(all.equal(unname(env$reference$b), c(1/4, 8/9))),
          isTRUE(all.equal(env$reference$index_variance, 265/36)),
          isTRUE(all.equal(env$reference$index_objective_covariance, 265/36)))
