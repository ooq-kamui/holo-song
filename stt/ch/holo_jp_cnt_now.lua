cjson   = require("cjson")
api_key = require("ytube-data-api-key")
require("path")
require("utl")
require("holo")

Holo_ch = {}
function Holo_ch.new(cntry)

  local obj = {}
  for name, fnc in pairs(Holo_ch) do
    if type(fnc) == "function" then obj[name] = fnc end
  end

  obj:init(cntry)

  return obj
end

function Holo_ch.init(_s, cntry)

  _s:mmbr__init(cntry)
  _s:name__init()
end

function Holo_ch.mmbr__init(_s, cntry)

  _s._mmbr = Holo.mmbr(nil, cntry)
end

function Holo_ch.name__init(_s)

  _s._name = {}

  for name, tbl in pairs(_s._mmbr) do
    table.insert(_s._name, name)
  end
end

function Holo_ch.mmbr(_s)

  return _s._mmbr
end

function Holo_ch.name(_s)

  return _s._name
end

function Holo_ch.cnt(_s)

  _s:cnt_req()
  _s:name_srt()
  _s:prnt()
end

function Holo_ch.cnt_req(_s)

  local api_key = api_key

  local ep      = "https://www.googleapis.com/youtube/v3/channels?"
  local prm_prt = "part".."=".."statistics"

  local ch_id = {}
  for name, tbl in pairs(_s:mmbr()) do
    table.insert(ch_id, tbl.ch_id)
  end
  local ch_id_str = table.concat(ch_id, ",")
	-- print(ch_id_str)

  local prm = {
    prm_prt,
    "id" .."="..ch_id_str ,
    "key".."="..api_key,
  }
  local qery = ep..table.concat(prm, "&")
  local cmd  = "curl -s '"..qery.."'"

  local hndl = io.popen(cmd)
  local jsn = hndl:read("*a")
  local tbl = cjson.decode(jsn)
  hndl:close()
  
  local cnt, name
  for idx, itm in pairs(tbl.items) do

    cnt  = tonumber(itm.statistics.subscriberCount) / 10000
    name = _s:name_by_id(itm.id)

    _s._mmbr[name].cnt = cnt
  end
end

function Holo_ch.name_srt(_s)

  local cmpr = function(name1, name2)

    if _s._mmbr[name1].cnt == _s._mmbr[name2].cnt then
      return name1 < name2
    end

    return _s._mmbr[name1].cnt > _s._mmbr[name2].cnt
  end
  table.sort(_s._name, cmpr)
end

function Holo_ch.name_by_id(_s, ch_id)

  for name, tbl in pairs(_s:mmbr()) do
    if tbl.ch_id == ch_id then return name end
  end
end

function Holo_ch.prnt(_s)

  for idx, name in pairs(_s._name) do
    print(name, string.format("%5.1f", _s._mmbr[name].cnt))
  end
end

-- main

local cntry = arg[1] or "jp"
local holo = Holo_ch.new(cntry)
holo:cnt()

