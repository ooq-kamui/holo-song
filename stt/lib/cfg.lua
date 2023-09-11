-- 
-- config
-- 

Cfg = {}
  
Cfg.prj = {
  -- dir = "/Users/kamui/doc/hoby/youtube/vtuber/holo/prj",
  dir = "/Users/kamui/doc/hoby/youtube/vtuber/holo/prj/stt",
}

-- ch

Cfg.ch = {
  dir_data  = Cfg.prj.dir .. "/stt/ch/data",
	file_ltst = "ltst.txt",
}
Cfg.ch.path_ltst = Cfg.ch.dir_data .. "/" .. Cfg.ch.file_ltst

-- song_video

Cfg.song_video = {
  dir_data = Cfg.prj.dir .. "/www/song/data/song_video",
	t_ltst_file = "ltst.t.json",
	s_ltst_file = "ltst.s.json",
}
Cfg.song_video.path_t_ltst = Cfg.song_video.dir_data .. "/ltst.t.json"
Cfg.song_video.path_s_ltst = Cfg.song_video.dir_data .. "/ltst.s.json"

-- ch_video

Cfg.ch_video = {
	dir_data     = Cfg.prj.dir .. "/www/song/data/ch_video",
	svr_dir_data = "song/data/ch_video",
}
function Cfg.ch_video.path_jsn(name)
	
	local path = u.c(Cfg.ch_video.dir_data, "/", name, "/", name, ".json")
	return path
end

-- 
-- etc
-- 

Cfg.jsn = {
  encode = {
    dir = Cfg.prj.dir .. "/stt/tmp/jsn",
  },
}
tmp = Cfg.jsn.encode -- tmp alias
Cfg.jsn.encode.tmp_file = tmp.dir .. "/tmp.json"


Cfg.ul = { -- scp
  host = "ooq@ooq.sakura.ne.jp",
	dir  = "~/www/holo",
}
Cfg.ul.host_dir = Cfg.ul.host .. ":" .. Cfg.ul.dir

