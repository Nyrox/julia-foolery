
using Makie
using AbstractPlotting

using FileIO, Colors

using LinearAlgebra

scene = Scene()

scene = mesh(Sphere(Point3f0(0), 0.9f0), transparency=true, alpha=0.05)

function cosine_weighted_sample_hemisphere()
	r1 = rand()
	r2 = rand()

	theta = acos(sqrt(r1))
	phi = 2π * r2

	Point3f0(sin(theta)cos(phi), cos(theta), sin(theta)sin(phi))
end


function plot_directions!(scene, N, generator) 
	dirs = []
	for i in 1:N 
		push!(dirs, generator())
	end

	arrows!(
		scene,
		fill(Point3f0(0), N),
		dirs,
		arrowcolor=:red,
		arrowsize=0.1,
		linecolor=:red
	)
end


FOV = π/4.0 * (180.0 / π)
ASPECT = 16.0 / 9.0
NEAR = 1.0
FAR = 1000.0

S = 1.0 / tan(0.5FOV * (π/180.0))

# Projection Matrix
# https://www.scratchapixel.com/lessons/3d-basic-rendering/perspective-and-orthographic-projection-matrix/building-basic-perspective-projection-matrix
PROJECTION = [
	S 0 0 0;
	0 S 0 0;
	0 0 (-FAR / (FAR - NEAR)) -1;
	0 0 (-FAR * NEAR / (FAR - NEAR)) 0
]




function world_from_depth(depth)
	z = depth * 2.0 - 1.0


end


depth = try
	load("depth.png")
catch e
	@warn("Loading depth texture failed")
	exit()
end

# plot_directions!(scene, 100, cosine_weighted_sample_hemisphere)

scene = image(depth, show_axis=false)
rotate!(scene, -0.5π)

pixel = fill(RGBAf0(1.0, 0.0, 0.0, 1.0), 10, 10)

image!(scene, pixel, show_axis=false, position=(100, 100))

scene