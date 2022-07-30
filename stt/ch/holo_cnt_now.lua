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
  _s:ch__init()
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

function Holo_ch.ch__init(_s)
  
  _s._ch_id = {}
  
  for name, tbl in pairs(_s:mmbr()) do
    table.insert(_s._ch_id, tbl.ch_id)
  end
end

function Holo_ch.mmbr(_s)

  return _s._mmbr
end

function Holo_ch.name(_s)

  return _s._name
end

function Holo_ch.ch_id(_s)

  return _s._ch_id
end

function Holo_ch.ch_cnt__(_s)

  local res = Ytube.ch_cnt(_s:ch_id())
  
  local cnt, name
  for idx, itm in pairs(res.items) do

    cnt  = tonumber(itm.statistics.subscriberCount) / 10000
    name = _s:name_by_id(itm.id)

    _s._mmbr[name].cnt = cnt
  end
  
  _s:mmbr__srt_name()
end

function Holo_ch.mmbr__srt_name(_s)

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
local holo_ch = Holo_ch.new(cntry)
holo_ch:ch_cnt__()
holo_ch:prnt()

