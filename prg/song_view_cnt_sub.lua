require("holo")

if not arg[1] or not arg[2] then os.exit() end

local jsn_path1 = arg[1] -- new
local jsn_path2 = arg[2] -- pre

local jsn1   = Utl.file_read(jsn_path1)
local video1 = cjson.decode(jsn1)

local jsn2   = Utl.file_read(jsn_path2)
local video2 = cjson.decode(jsn2)

local holo = Holo.new()
-- holo:video__sub_view_cnt(video1, video2)
holo:video__(   video1)
holo:video__sub(video2)
holo:video_2_jsn()

