# Run or source from the package root. No installation or large-data tests.
local({
  package <- read.dcf("DESCRIPTION")[1, "Package"]
  examples <- c("breeding_objectives", "selection_indices")
  loaded <- list()
  for (name in examples) {
    path <- file.path("inst/examples", paste0(name, ".R"))
    text <- paste(readLines(path, warn = FALSE), collapse = "\n")
    code <- trimws(strsplit(text, "# Plotting helper", fixed = TRUE)[[1]][1])
    slug <- gsub("_", "-", name, fixed = TRUE)
    tutorial <- paste(readLines(file.path("docs/tutorials", paste0(slug, ".md")),
                                warn = FALSE), collapse = "\n")
    # (?s) makes the match span multiple lines.
    first_code <- regmatches(tutorial, regexec("(?s)```r\n(.*?)\n```", tutorial, perl = TRUE))[[1]]
    stopifnot(length(first_code) == 2L, identical(trimws(first_code[2]), code))
    environment <- new.env(parent = baseenv())
    sys.source(path, envir = environment)
    loaded[[name]] <- environment
  }
  close_to <- function(actual, expected) {
    stopifnot(isTRUE(all.equal(unname(actual), unname(expected), tolerance = 1e-12)))
  }
  objective <- loaded[["breeding_objectives"]]
  close_to(objective$H, c(4, 6, 5, 4))
  close_to(objective$ranking, c(3, 1, 2, 3))
  close_to(objective$H_growth, c(13.5, 11.5, 8.75, 16))
  close_to(objective$H_grams, c(4, 6, 5, 4))
  index <- loaded[["selection_indices"]]
  close_to(index$b, c(22/35, -18/35))
  close_to(index$I, c(26/35, 40/35, 14/35, -6/35))
  close_to(index$naive_score, c(3, 3, 0, 2))
  close_to(index$variance_I, 116/35)
  close_to(index$covariance_I_H, 116/35)
  close_to(index$variance_H, 13)
  close_to(index$accuracy, sqrt(116/455))
  joint <- rbind(cbind(index$P, index$C), cbind(t(index$C), index$G))
  stopifnot(min(eigen(joint, symmetric = TRUE, only.values = TRUE)$values) > 0)
  reordered <- c("feed", "growth")
  close_to(drop(solve(index$P[reordered, reordered],
                     index$C[reordered, reordered] %*% index$a[reordered])), rev(index$b))
  cat(package, ": two teaching examples and their displayed code verified\n", sep = "")
})
