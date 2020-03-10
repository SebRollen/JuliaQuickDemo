using RCall, RDatasets

mtcars = dataset("datasets", "mtcars")

R"library(ggplot2)"

R"""ggplot($mtcars, aes(x=WT, y=MPG)) +
    geom_point()
"""

vector = R"c(1, 2, 3)" |> rcopy
matrix = R"matrix(c(1, 2, 3, 4), ncol = 2)" |> rcopy
