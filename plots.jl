using Plots, UnicodePlots

data = rand(10)
plot!(data)
scatter(data)
scatter!(rand(10))

unicodeplots()
plot(data)

gr()
plot(data)

# Makie
using Makie
function xy_data(x, y)
    r = sqrt(x^2 + y^2)
    r == 0.0 ? 1f0 : (sin(r)/r)
end

r = range(-2, stop = 2, length = 50)
surf_func(i) = [Float32(xy_data(x*i, y*i)) for x = r, y = r]
z = surf_func(20)

scene = Scene();
surf = surface!(scene, r, r, z)[end]
wf = wireframe!(scene, r, r, lift(x-> x .+ 1.0, surf[3]),
    linewidth = 2f0, color = lift(x-> to_colormap(x)[5], surf[:colormap])
)
N = 150
scene
record(scene, "animated_surface_and_wireframe.mp4", range(5, stop = 40, length = N)) do i
    surf[3] = surf_func(i)
end
