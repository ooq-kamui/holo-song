-- package.path = package.path .. ";../lib/?.lua"

require("path")
require("holo")

if not arg[1] or not arg[2] then os.exit() end

local jsn_path1 = arg[1] -- base
local jsn_path2 = arg[2] -- add

local jsn1   = Utl.file_read(jsn_path1)
local video1 = cjson.decode(jsn1)

local jsn2   = Utl.file_read(jsn_path2)
local video2 = cjson.decode(jsn2)

local holo = Holo.new()
holo:video__(   video1)
holo:video__add(video2)
holo:video_2_jsn()

