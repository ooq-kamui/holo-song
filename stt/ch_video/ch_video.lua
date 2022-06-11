-- package.path = package.path .. ";../lib/?.lua"

require("path")
require("holo")

local mmbr_name = arg[1]
local ch_id = Holo._jp.mmbr[mmbr_name].ch_id

local holo = Holo.new()
holo:video__by_ch(ch_id)
holo:video_2_jsn()

