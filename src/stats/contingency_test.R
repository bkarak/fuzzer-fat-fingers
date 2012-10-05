data.dir <- "."
args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 0) {
  data.dir <- args[1]
}
filenames <- list.files(path = data.dir, pattern="text$", full.names=TRUE)
for (filename in filenames) {
  data <- read.table(filename)
  cat("TEST:", filename, "\n")
  for (i in 1:(nrow(data)-1)) {
    for (j in (i+1):nrow(data)) {
      m <- data[c(i, j),][-1]
      colnames(m) <- c("passed", "caught")
      rownames(m) <- data[,1][c(i, j)]
      cat(sprintf("testing %s for %s and %s\n", filename, rownames(m)[1], rownames(m)[2]));
      print(m)
      r <- fisher.test(m)
      cat("result", r$p.value, "\n")
      if (r$p.value >= 0.05) {
        cat(sprintf("%s null hypothesis not rejected for %s and %s, p-value=%f\n", filename, rownames(m)[1], rownames(m)[2], r$p.value));
      } 
      cat("=====\n")
    }
  }
}
