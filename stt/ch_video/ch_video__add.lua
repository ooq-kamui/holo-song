require("path")
require("holo")

local cntry   = "jp"

-- local fr_date = Utl.date_y2()
local fr_date = Utl.date_y(7)

local to_date = Utl.date_t0()
local term = fr_date..".-."..to_date
u.log(term)

local holo = Holo.new()

local ch_id
local video1, video2
local dir, dir_add, dir_ttl
local path_name_jsn, path_add_jsn, path_ttl_jsn
local add_file
-- local path_wc

local mmbr = holo:mmbr(cntry)

for name, tbl in pairs(mmbr) do
	-- name = "aki" -- tst
	u.log(name)
	
	dir     = u.c(Cfg.ch_video.dir_data, "/", name)
	dir_add = u.c(dir, "/add")
	
	-- 
	-- add file cre write
	-- 
	
	path_add_jsn = dir_add.."/"..name.."."..term..".json"
	
	---[[
	ch_id = Holo["_"..cntry].mmbr[name].ch_id
	holo:video__by_ch(ch_id, fr_date)
	
	-- u.log(path_add_jsn)
	holo:video_2_jsn_write(path_add_jsn)
	--]]
	
	-- 
	-- name file __ add
	-- 
	
	---[[
	path_name_jsn = dir.."/"..name..".json"
	
	holo:video__by_jsn_file(path_name_jsn)
	
	add_file = {path_add_jsn}
	
	for idx, _add_file in pairs(add_file) do
		-- u.log(_add_file)
		
		video2 = Utl.tbl_by_jsn_file(_add_file)
		
		holo:video__add(video2)
	end
	
	-- holo:video_view_cnt__0()
	
	dir_ttl      = dir.."/ttl"
	path_ttl_jsn = dir_ttl.."/"..name.."."..Utl.date()..".json"
	
	holo:video_2_jsn_write(path_ttl_jsn)
	Utl.cp(path_ttl_jsn, path_name_jsn)
	--]]
	
	-- break -- tst
end

-- 
-- data rsync
-- 
Utl.cmd("fish rsync.data.ch_video.fish")

