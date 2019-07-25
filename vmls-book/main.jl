
function dot_product(v1, v2) 
	len = min(length(v1), length(v2))
	sum = 0

	for i in 1:len 
		sum += v1[i] * v2[i]
	end

	sum
end



show(dot_product([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], fill(1/10, 10)))