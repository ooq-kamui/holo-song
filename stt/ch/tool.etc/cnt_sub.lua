require("utl_ch")

-- main

file1 = arg[1]
file2 = arg[2]

tbl1 = read_cnt(file1)
tbl2 = read_cnt(file2)

sub_tbl = tbl_sub(tbl1, tbl2)

for name, cnt in pairs(sub_tbl) do

	print(name, string.format("%5.1f",cnt))
end

