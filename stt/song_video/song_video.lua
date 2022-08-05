require("path")
require("holo")

local holo = Holo.new()
holo:main_song_video()

function Holo.main_song_video(_s)
	
	_s:video__song_ttl_write()

	_s:video__song_sub_write()

	_s:song_data_rsync()
end

function Holo.video__song_ttl_write(_s)
	
	local path_song_video_total
	
	-- dbg
	-- path_song_video_total = Cfg.song_video.dir_data.."/2022-08-05.02:38.json"
	-- _s:video__by_jsn_file(path_song_video_total)

	path_song_video_total = Cfg.song_video.dir_data.."/"..Utl.datetime()..".json"
	
	_s:video__song({"jp", "en", "id"})

	_s:video_2_jsn_write(path_song_video_total)

	Utl.cp(path_song_video_total, Cfg.song_video.path_t_ltst)
end

function Holo.video__song_sub_write(_s)
	
	local path_jsn = _s:song_video_jsn_file_ltst()

	local video1 = Utl.tbl_by_jsn_file(path_jsn[1])
	local video2 = Utl.tbl_by_jsn_file(path_jsn[2])

	_s:video__(   video1)
	_s:video__sub(video2)

	local file_jsn1 = Utl.basename(path_jsn[1])
	local file_jsn2 = Utl.basename(path_jsn[2])

	local file_sub = Utl.ext_del(file_jsn1)..".-."..file_jsn2
	local path_sub = Cfg.song_video.dir_data.."/"..file_sub

	_s:video_2_jsn_write(path_sub)

	Utl.cp(path_sub, Cfg.song_video.path_s_ltst)
end

function Holo.song_video_jsn_file_ltst(_s)
	
	local path_wc  = Cfg.song_video.dir_data.."/????-??-??.??:??.json"
	local path_jsn = Utl.ls(path_wc, "-r")
	-- u.log_ar(path_jsn)
	
	return path_jsn
end

function Holo.song_data_rsync(_s)
	
	Utl.cmd("fish rsync.data.song_video.fish")
end

