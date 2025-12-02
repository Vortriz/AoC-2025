### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 71173682-aa33-4322-b0a1-5bc27a2ee1fe
md"# Part 1"

# ╔═╡ 584b3dc7-d7c9-420b-8fa7-c960a715e92d
function readinput(filename)
	open(filename) do f
		rotations = Vector()
		
		while ! eof(f)
			r = readline(f)
			push!(rotations, r)
		end

		return rotations
	end
end

# ╔═╡ d815bd97-408e-48d4-98fb-04fedf952f27
function rotations_to_shifts(rotations)
	shifts = Vector{Int}()
	
	for r in rotations
		s = if r[1] == 'R'
			parse(Int, r[2:end])
		else
			-parse(Int, r[2:end])
		end
		
		push!(shifts, s)
	end
	
	return shifts
end

# ╔═╡ 7543480e-809d-4db9-90f8-d5d174f27ab5
function shifts_to_pos(shifts)
	pushfirst!(shifts, 50)
	pos = mod.(cumsum(shifts), 100)
	return pos
end

# ╔═╡ 0baff896-0fac-4859-b5a7-130f729cfe7c
function part1(file)
	rotations = readinput(file)
	shifts = rotations_to_shifts(rotations)
	pos = shifts_to_pos(shifts)
	
	return count(==(0), pos)
end

# ╔═╡ b1f18872-5ddf-4907-a2ee-03b5a54a3923
part1("sample")

# ╔═╡ 1c3dc76f-31a9-4b3c-b033-9cc9f909a395
part1("input")

# ╔═╡ fd755897-4ab4-4738-a650-553c57e61bf9
md"# Part 2"

# ╔═╡ 2f33f05b-25e1-4637-8ee9-8eea5e7d862c
function part2(file)
	rotations = readinput(file)
	shifts = rotations_to_shifts(rotations)
	pushfirst!(shifts, 50)
	pos = cumsum(shifts)
	c = 0
	for i in 1:length(pos)-1
		if (pos[i] > pos[i+1]) step = -1 else step = 1 end
		c += count(==(0), collect(range(start=pos[i], stop=pos[i+1], step=step)) .% 100)
	end
	
	return c - part1(file)
end

# ╔═╡ e0a683cf-6ef3-48db-a086-3c6bac81a9e6
part2("sample")

# ╔═╡ ed365812-05af-4e17-bb38-110e548afd51
part2("input")

# ╔═╡ Cell order:
# ╟─71173682-aa33-4322-b0a1-5bc27a2ee1fe
# ╠═584b3dc7-d7c9-420b-8fa7-c960a715e92d
# ╠═d815bd97-408e-48d4-98fb-04fedf952f27
# ╠═7543480e-809d-4db9-90f8-d5d174f27ab5
# ╠═0baff896-0fac-4859-b5a7-130f729cfe7c
# ╠═b1f18872-5ddf-4907-a2ee-03b5a54a3923
# ╠═1c3dc76f-31a9-4b3c-b033-9cc9f909a395
# ╟─fd755897-4ab4-4738-a650-553c57e61bf9
# ╠═2f33f05b-25e1-4637-8ee9-8eea5e7d862c
# ╠═e0a683cf-6ef3-48db-a086-3c6bac81a9e6
# ╠═ed365812-05af-4e17-bb38-110e548afd51
