require("path")
require("holo")

local holo = Holo.new()

-- 
-- song_video total
-- 

local path_song_video_total = Cfg.song_video.dir_data.."/"..Utl.datetime()..".json"

holo:video__song({"jp", "en", "id"})
holo:video_2_jsn_write(path_song_video_total)

Utl.cp(path_song_video_total, Cfg.song_video.path_t_ltst)

-- 
-- song_video sub
-- 

local path_wc  = Cfg.song_video.dir_data.."/????-??-??.??:??.json"
local path_jsn = Utl.ls(path_wc, "-r")
-- u.log_ar(path_jsn)

local video1 = Utl.tbl_by_jsn_file(path_jsn[1])
local video2 = Utl.tbl_by_jsn_file(path_jsn[2])

holo:video__(   video1)
holo:video__sub(video2)

local file_jsn1 = Utl.basename(path_jsn[1])
local file_jsn2 = Utl.basename(path_jsn[2])

local file_sub = Utl.ext_del(file_jsn1)..".-."..file_jsn2
local path_sub = Cfg.song_video.dir_data.."/"..file_sub

holo:video_2_jsn_write(path_sub)

Utl.cp(path_sub, Cfg.song_video.path_s_ltst)

-- 
-- data rsync
-- 
Utl.cmd("fish rsync.data.song_video.fish")

