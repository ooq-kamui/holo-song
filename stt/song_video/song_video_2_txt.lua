require("path")
require("holo")

if not arg[1] then os.exit() end

local jsn_file = arg[1]

local holo = Holo.new()
holo:video__jsn_file(jsn_file)
holo:video_view_cnt_2_txt()

