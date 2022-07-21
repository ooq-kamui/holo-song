
function split_tab(line)

	local s, e = string.find(line, "\t")

	local name, cnt
	name = string.sub(line, 1, s)
	cnt  = string.sub(line, e + 1)

	return name, cnt
end

function read_cnt(file)
	-- print("read_cnt:" .. file)

	local tbl = {}

	local f = io.open(file)

	local name, cnt
	for line in f:lines() do

		name, cnt = split_tab(line)
		tbl[name] = cnt
	end

	io.close(f)

	return tbl
end

function tbl_sub(tbl1, tbl2)

	local r_tbl = {}

	for name, cnt1 in pairs(tbl1) do

		r_tbl[name] = cnt1 - tbl2[name]
	end

	return r_tbl
end

