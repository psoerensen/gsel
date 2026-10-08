# Reference covariance algebra only, not a fitted predictor or index API.
# H = a' u; P = Var(x); C = Cov(x,u). No selection response is claimed.
traits <- c('trait_a', 'trait_b')
a <- structure(c(1, 2), names = traits)
P <- diag(c(4, 9)); dimnames(P) <- list(traits, traits)
C <- diag(c(1, 4)); dimnames(C) <- list(traits, traits)
b <- drop(solve(P, C %*% a))
index_variance <- drop(crossprod(b, P %*% b))
index_objective_covariance <- drop(crossprod(b, C %*% a))
reference <- list(a = a, P = P, C = C, b = b,
                  index_variance = index_variance,
                  index_objective_covariance = index_objective_covariance)
