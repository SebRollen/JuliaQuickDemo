using DataFrames, DataFramesMeta

df = DataFrame(a = [1, 2, 3], b = ["B", "B", "A"])

# Selection
df.a
df[:, :a]
@select(df, :a)

# Filtering
df[df.b .== "B", :]
filter(r -> r.b == "B", df)
@where(df, :b .== "B")

# Changing
df[!, :c1]   .= sin.(df.a)    # mutating
@transform(df, c2 = sin.(:a)) # non-mutating

# Sorting
df[sortperm(df.b), :]
sort(df, :b)
@orderby(df, :b)

# Aggregating
by(df, :b, s = :a => sum)
@by(df, :b, s = sum(:a))
by(df, :b) do df
    (s = sum(df.a), m = sum(df.a)/length(df.a))
end
aggregate(df, :b, size)

# Pipes
@linq df |>
    where(:b .== "B") |>
    orderby(:c1)
