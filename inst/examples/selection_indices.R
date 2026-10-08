# Centered measurements x and additive breeding values u are different.
# Measurement values below use a fixed external reference mean.
traits <- c("growth", "feed")
x <- rbind(A = c(growth = 2, feed = 1),
           B = c(growth = 1, feed = -1),
           C = c(growth = -1, feed = -2),
           D = c(growth = 3, feed = 4))
a <- c(growth = 2, feed = -1)

# Hypothetical population moments; not estimates from these four candidates.
P <- matrix(c(4, 1, 1, 9), nrow = 2,
            dimnames = list(traits, traits))  # Var(x)
C <- diag(c(1, 4))                          # Cov(x, u)
G <- diag(c(2, 5))                          # Var(u)
dimnames(C) <- dimnames(G) <- list(traits, traits)
stopifnot(identical(colnames(x), rownames(P)),
          identical(colnames(C), names(a)))

# Solve the best-linear-prediction covariance equation P b = C a.
b <- drop(solve(P, C %*% a))
I <- drop(x %*% b)
naive_score <- drop(x %*% a)
variance_I <- drop(crossprod(b, P %*% b))
covariance_I_H <- drop(crossprod(b, C %*% a))
variance_H <- drop(crossprod(a, G %*% a))
accuracy <- covariance_I_H / sqrt(variance_I * variance_H)
reference <- list(P = P, C = C, G = G, a = a, b = b,
                  x = x, I = I, naive_score = naive_score,
                  variance_I = variance_I, covariance_I_H = covariance_I_H,
                  variance_H = variance_H, accuracy = accuracy)

# Plotting helper for this teaching script, not an exported package API.
plot_tutorial <- function() {
  old <- graphics::par(mfrow = c(1, 2), mar = c(4.5, 4.5, 3.5, 1))
  on.exit(graphics::par(old))
  graphics::barplot(b, col = c("#247BA0", "#D8A47F"), ylim = c(-0.7, 0.8),
    ylab = "Index coefficient", main = "Weights reflect information quality")
  graphics::abline(h = 0, col = "grey50")
  graphics::barplot(I, col = "#70A288", ylim = c(-0.4, 1.4),
    ylab = "Index (currency units)", xlab = "Candidate",
    main = "Rank supplied measurements")
  graphics::abline(h = 0, col = "grey50")
}
