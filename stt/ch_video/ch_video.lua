require("path")
require("holo")

local mmbr_name = arg[1]
local ch_id = Holo._jp.mmbr[mmbr_name].ch_id
-- local ch_id = "UCgIfLpQvelloDi8I0Ycbwpg" -- salome

local fr_date = arg[2]

local holo = Holo.new()
holo:video__by_ch(ch_id, fr_date)
holo:video_2_jsn()

