require("path")
require("Utl")
require("holo_ch")

local cntry = arg[1] or "jp"

local holo_ch = Holo_ch.new(cntry)

holo_ch:ch_cnt__()

local path_ch_cnt = Cfg.ch.dir_data.."/cnt."..Utl.date()..".txt"
holo_ch:ch_cnt_2_txt_write(path_ch_cnt)

-- cp ltst
Utl.cp(path_ch_cnt, Cfg.ch.path_ltst)

