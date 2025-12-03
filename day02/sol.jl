### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 6d3161b3-93b5-4955-aadd-2487cc181af3
function readinput(filename)
	open(filename) do f
		return readline(f)
	end
end

# ╔═╡ 04f0f52d-6089-403a-824e-6c69a63508e8
md"# Part 1"

# ╔═╡ c2bb566b-8f63-4b3e-9c47-36f51e139b68
function get_ids(input)
	return vcat(map(x -> range(x...), map(x -> parse.(Int, x), split.(split(input, ","), "-")))...)
end

# ╔═╡ 8b982222-cf55-11f0-9bef-7b2c7856c434
function part1(filename)
	input = readinput(filename)
	
	return sum(filter(x -> string(x)[1:end÷2] == string(x)[end÷2+1:end], get_ids(input)))
end

# ╔═╡ 485f9e5a-f0c6-4fbd-9628-3f4842d66ecc
part1("sample")

# ╔═╡ 81d38318-aff6-4962-bcd4-ddc6869ceda5
part1("input")

# ╔═╡ 0df08696-bdf4-428e-98d3-ee7ae1dddee1
md"# Part 2"

# ╔═╡ 87379bf9-12c2-4239-8e05-164fadcf0f98
function chunks(arr, n)
	return [arr[i:min(i + n - 1, length(arr))] for i in 1:n:length(arr)]
end

# ╔═╡ 010ba628-efd7-4be2-8e7c-ce589dbc7010
function invalidity(id)
	for n in 1:ndigits(id)÷2
		if allequal(chunks(string(id), n))
			return id
		end
	end
end

# ╔═╡ 3389d740-0393-4917-bf63-c78f560addb0
function part2(filename)
	input = readinput(filename)
	ids = get_ids(input)
	
	return sum(filter(!isnothing, invalidity.(ids)))
end

# ╔═╡ e9e2e19c-f7e2-4330-adf3-502f0b36b167
part2("sample")

# ╔═╡ 62851731-6385-4c2c-a4bb-0a959cf3bbed
part2("input")

# ╔═╡ Cell order:
# ╠═6d3161b3-93b5-4955-aadd-2487cc181af3
# ╟─04f0f52d-6089-403a-824e-6c69a63508e8
# ╠═c2bb566b-8f63-4b3e-9c47-36f51e139b68
# ╠═8b982222-cf55-11f0-9bef-7b2c7856c434
# ╠═485f9e5a-f0c6-4fbd-9628-3f4842d66ecc
# ╠═81d38318-aff6-4962-bcd4-ddc6869ceda5
# ╟─0df08696-bdf4-428e-98d3-ee7ae1dddee1
# ╠═87379bf9-12c2-4239-8e05-164fadcf0f98
# ╠═010ba628-efd7-4be2-8e7c-ce589dbc7010
# ╠═3389d740-0393-4917-bf63-c78f560addb0
# ╠═e9e2e19c-f7e2-4330-adf3-502f0b36b167
# ╠═62851731-6385-4c2c-a4bb-0a959cf3bbed
