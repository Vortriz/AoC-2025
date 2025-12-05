### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 81224126-d005-11f0-9885-050679e3ce86
function readinput(filename)
	open(filename) do f
		banks = Vector()
		
		while ! eof(f)
			b = readline(f)
			push!(banks, b)
		end

		return map(x -> parse.(Int, x), split.(banks, ""))
	end
end

# ╔═╡ 6096893a-6800-4311-a5c0-f183a19951e6
md"# Part 1"

# ╔═╡ 989e2ec6-1a93-4362-abf7-b0dfda677f73
function part1(banks)
	sum = 0
	
	for bank in banks
		pos = argmax(bank[1:end-1])
		first_digit = bank[pos]
		last_digit = maximum(getindex(bank, pos+1:lastindex(bank)))
		num = parse(Int, string(first_digit, last_digit))
		sum += num
	end

	return sum
end

# ╔═╡ 9d1d0be9-9599-4231-b0a7-e8942e02b0e9
part1(readinput("sample"))

# ╔═╡ 4cffeaa4-45fc-41a6-8d10-c46984299ed5
part1(readinput("input"))

# ╔═╡ f0fbc3c8-77d5-4747-a9b3-e18fb61f2de9
md"# Part 2"

# ╔═╡ 9b130a67-4846-414f-9f17-1f103e8390a1
function part2(banks)
	joltages = Vector{Int}()
	
	for bank in banks
		batteries = Vector{Int}()
		pos = 0
		for n in 11:-1:0
			sl = bank[pos+1:end-n]
			pos += argmax(sl)
			push!(batteries, bank[pos])
		end

		push!(joltages, parse(Int, join(batteries)))
	end

	return sum(joltages)
end

# ╔═╡ 26e46ad5-1f1b-4da9-8167-6048d3500f7f
part2(readinput("sample"))

# ╔═╡ 84f88a55-d350-4f00-9046-51261779e049
part2(readinput("input"))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.1"
manifest_format = "2.0"
project_hash = "71853c6197a6a7f222db0f1978c7cb232b87c5ee"

[deps]
"""

# ╔═╡ Cell order:
# ╠═81224126-d005-11f0-9885-050679e3ce86
# ╟─6096893a-6800-4311-a5c0-f183a19951e6
# ╠═989e2ec6-1a93-4362-abf7-b0dfda677f73
# ╠═9d1d0be9-9599-4231-b0a7-e8942e02b0e9
# ╠═4cffeaa4-45fc-41a6-8d10-c46984299ed5
# ╟─f0fbc3c8-77d5-4747-a9b3-e18fb61f2de9
# ╠═9b130a67-4846-414f-9f17-1f103e8390a1
# ╠═26e46ad5-1f1b-4da9-8167-6048d3500f7f
# ╠═84f88a55-d350-4f00-9046-51261779e049
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
