-- 
-- config
-- 

Cfg = {}
  
Cfg.prj = {
  dir = "/Users/kamui/doc/hoby/youtube/vtuber/hololive/prj",
}

Cfg.json = {
  encode = {
    dir = Cfg.prj.dir .. "/stt/tmp/json",
  },
}
tmp = Cfg.json.encode -- tmp alias
Cfg.json.encode.tmp_file = tmp.dir .. "/tmp.json"

Cfg.ch = {
  data = {
		dir = Cfg.prj.dir .. "/stt/ch/data",
	},
}

Cfg.song_video = {
  data = {
		dir = Cfg.prj.dir .. "/www/song/data",
	},
}

Cfg.ch_video = {
  data = {
		dir = Cfg.song_video.data.dir .. "/ch",

	},
}

