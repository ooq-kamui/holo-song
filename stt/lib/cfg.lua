-- 
-- config
-- 

Cfg = {}
  
Cfg.prj = {
  dir = "/Users/kamui/doc/hoby/youtube/vtuber/hololive/prj",
}

Cfg.ch = {
  data = {
		dir = Cfg.prj.dir .. "/stt/ch/data",
	},
}

Cfg.song_video = {
  data = {
		dir = Cfg.prj.dir .. "/www/song/data/song_video",
	},
}

Cfg.ch_video = {
  data = {
		dir = Cfg.prj.dir .. "/www/song/data/ch",
	},
	svr_dir_data = "song/data/ch",
}

Cfg.jsn = {
  encode = {
    dir = Cfg.prj.dir .. "/stt/tmp/jsn",
  },
}
tmp = Cfg.jsn.encode -- tmp alias
Cfg.jsn.encode.tmp_file = tmp.dir .. "/tmp.json"

Cfg.ul = { -- scp
  host = "ooq@ooq.sakura.ne.jp",
	dir  = "~/dev/www/pri/holo",
}
Cfg.ul.host_dir = Cfg.ul.host .. ":" .. Cfg.ul.dir

