# Simulate distance matrix
H <- matrix(c(
  00, 00, 00, 00, 00, 00,
  01, 00, 00, 00, 00, 00,
  03, 01, 00, 00, 00, 00,
  21, 18, 28, 00, 00, 00,
  23, 25, 31, 07, 00, 00,
  19, 27, 23, 09, 11, 00
), ncol = 6, byrow = TRUE)

# Make matrix symmetric
H <- H + t(H)
colnames(H) <- LETTERS[1:ncol(H)]

# Dendrogram
hc <- hclust(as.dist(H))

# Select THD parameters
m   <- 64
mu  <- 0.001
t50 <- 20

# Compute THD values
x <- thd(H, t50, m, mu, scale = "time")

# Visualize dendrogram and THD
par(mfrow = c(2, 1))
par(mar = c(2, 10, 2, 10))
plot(hc, hang = -1, xlab = "", yaxt = "n", ylab = "")
par(mar = c(2, 4, 2, 4))
barplot(x[hc$order], xlim = c())
