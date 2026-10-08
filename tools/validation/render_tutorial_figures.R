# Explicit developer action: reproduce intentional SVG tutorial source assets.
# Run or source from the package root; website builds do not call this script.
local({
  source("tools/validation/check_tutorials.R")
  examples <- c("breeding_objectives", "selection_indices")
  dir.create("docs/tutorials/figures", recursive = TRUE, showWarnings = FALSE)
  dir.create("pkgdown/assets/figures", recursive = TRUE, showWarnings = FALSE)
  dir.create("build/tutorial-previews", recursive = TRUE, showWarnings = FALSE)
  for (name in examples) {
    environment <- new.env(parent = baseenv())
    sys.source(file.path("inst/examples", paste0(name, ".R")), envir = environment)
    slug <- gsub("_", "-", name, fixed = TRUE)
    svg <- file.path("docs/tutorials/figures", paste0(slug, ".svg"))
    grDevices::svg(svg, width = 9, height = 4.5, pointsize = 11)
    tryCatch(environment$plot_tutorial(), finally = grDevices::dev.off())
    if (!file.copy(svg, file.path("pkgdown/assets/figures", basename(svg)), overwrite = TRUE)) {
      stop("Could not refresh figure asset: ", svg)
    }
    grDevices::png(file.path("build/tutorial-previews", paste0(slug, ".png")),
                   width = 1350, height = 675, res = 150, pointsize = 11)
    tryCatch(environment$plot_tutorial(), finally = grDevices::dev.off())
  }
})
