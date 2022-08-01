require("path")
require("holo")

local cntry   = "jp"
local fr_date = Utl.date_y2()
local to_date = Utl.date_t0()

local holo = Holo.new()
local mmbr = holo:mmbr(cntry)

local ch_id
local video1, video2
local dir, dir_add
local name_jsn_file, name_term_jsn_file
local add_file
-- local path_wc

for name, tbl in pairs(mmbr) do
	-- name = "aki" -- tst
	-- u.log(name)
	
	dir     = u.c(Cfg.ch_video.data.dir, "/", name)
	dir_add = u.c(dir, "/add")
	
	-- 
	-- add file cre write
	-- 
	
	ch_id = Holo["_"..cntry].mmbr[name].ch_id
	holo:video__by_ch(ch_id, fr_date)
	
	name_term_jsn_file = u.c(dir_add, "/", name, ".", fr_date, ".-.", to_date, ".json")
	holo:video_2_jsn_write(name_term_jsn_file)
	
	-- 
	-- name file __ add
	-- 
	
	name_jsn_file = u.c(dir, "/", name, ".json")
	
	holo:video__by_jsn_file(name_jsn_file)
	
	-- path_wc = u.c(dir_add, "/", name, ".*.-.*.json")
	-- add_file = Utl.ls(path_wc)
	add_file = {name_term_jsn_file}
	
	for idx, _add_file in pairs(add_file) do
		-- u.log(_add_file)
		
		video2 = Utl.tbl_by_jsn_file(_add_file)
		
		holo:video__add(video2)
	end
	
	holo:video_2_jsn_write(name_jsn_file)
	
	-- Utl.ul(name_jsn_file, "song/data/ch")
	-- break -- tst
end

-- 
-- data rsync
-- 
Utl.cmd("fish rsync.data.ch_video.fish")

