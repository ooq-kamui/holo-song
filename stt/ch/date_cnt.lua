require("utl_ch")

files = arg
files[ 0] = nil
files[-1] = nil

function date_cnt(files)

	local date_cnt = {}

	local date, tbl
	for idx, file in pairs(files) do

		date = string.sub(file, 18, 27)
		-- print(idx, date)

		tbl = read_cnt(file)

		for name, cnt in pairs(tbl) do

			if not date_cnt[name] then date_cnt[name] = {} end

			date_cnt[name][date] = cnt
		end
	end
	return date_cnt
end

function date_cnt_out(date_cnt)

	local date, date_hdr, cnt, line

	for name, tbl in pairs(date_cnt) do

		line = name
		date_hdr = ""

		date = tbl_key(tbl)
		table.sort(date)

		for idx, _date in pairs(date) do

			cnt = tbl[_date]
			line = line .. "\t".. cnt

			date_hdr = date_hdr .. "\t" .. _date
			-- print(_date)
		end
		-- print(line)
		print(line)
	end
	print(date_hdr)
end

function tbl_key(_ar)

	local keys = {}
	for key, val in pairs(_ar) do
		table.insert(keys, key)
	end
	return keys
end

-- main

date_cnt = date_cnt(files)

date_cnt_out(date_cnt)



