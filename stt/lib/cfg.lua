-- 
-- config
-- 

Cfg = {}
  
Cfg.prj = {
  dir = "/Users/kamui/doc/hoby/youtube/vtuber/hololive/prj",
}

-- ch

Cfg.ch = {
  data = {
		dir = Cfg.prj.dir .. "/stt/ch/data",
	},
}

-- song_video

Cfg.song_video = {
  dir_data = Cfg.prj.dir .. "/www/song/data/song_video",
	t_ltst_file = "t.ltst.json",
	s_ltst_file = "s.ltst.json",
}
Cfg.song_video.path_t_ltst = Cfg.song_video.dir_data .. "/t.ltst.json"
Cfg.song_video.path_s_ltst = Cfg.song_video.dir_data .. "/s.ltst.json"

-- ch_video

Cfg.ch_video = {
  data = {
		dir = Cfg.prj.dir .. "/www/song/data/ch_video",
	},
	svr_dir_data = "song/data/ch_video",
}

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

