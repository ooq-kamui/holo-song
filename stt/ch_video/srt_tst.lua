require("path")
require("holo")

local holo = Holo.new()

local path_jsn = Cfg.ch_video.path_jsn("aki")

local video1 = Utl.tbl_by_jsn_file(path_jsn)
holo:video__(video1)
holo:video_2_jsn_prnt()

