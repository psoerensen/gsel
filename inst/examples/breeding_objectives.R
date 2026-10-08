# Supplied additive breeding-value deviations on a fixed reference base.
# Both traits are measured in kg over the same production period.
u <- rbind(A = c(growth = 5, feed = 6),
           B = c(growth = 4, feed = 2),
           C = c(growth = 3, feed = 1),
           D = c(growth = 6, feed = 8))

# Hypothetical marginal values: currency units per kg.
a <- c(growth = 2, feed = -1)
stopifnot(identical(colnames(u), names(a)))
H <- drop(u %*% a)
ranking <- rank(-H, ties.method = "min")

# A different breeding objective changes the preferred candidate.
a_growth <- c(growth = 3, feed = -0.25)
H_growth <- drop(u %*% a_growth)

# Change growth from kg to g, with the corresponding value per g.
u_grams <- u
u_grams[, "growth"] <- 1000 * u_grams[, "growth"]
a_grams <- a
a_grams["growth"] <- a_grams["growth"] / 1000
H_grams <- drop(u_grams %*% a_grams)
reference <- list(u = u, a = a, H = H, ranking = ranking,
                  a_growth = a_growth, H_growth = H_growth, H_grams = H_grams)

# Plotting helper for this teaching script, not an exported package API.
plot_tutorial <- function() {
  old <- graphics::par(mfrow = c(1, 2), mar = c(4.5, 4.5, 3.5, 1))
  on.exit(graphics::par(old))
  graphics::barplot(H, col = "#247BA0", ylim = c(0, 7),
    ylab = "Objective (currency units)", xlab = "Candidate",
    main = "Growth value 2; feed value -1")
  graphics::barplot(H_growth, col = "#70A288", ylim = c(0, 18),
    ylab = "Objective (currency units)", xlab = "Candidate",
    main = "Growth value 3; feed value -0.25")
}
