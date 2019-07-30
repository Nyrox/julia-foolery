
using Makie
using AbstractPlotting

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


plot_directions!(scene, 100, cosine_weighted_sample_hemisphere)

scene