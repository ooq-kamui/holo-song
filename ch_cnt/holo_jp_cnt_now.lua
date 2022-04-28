
cjson   = require("cjson")

api_key = require("ytube-data-api-key")

Holo = {}
function Holo.new()

  local obj = {}
  for name, fnc in pairs(Holo) do
    if type(fnc) == "function" then obj[name] = fnc end
  end

  obj:init()

  return obj
end

function Holo.init(_s)

  _s:member_init()
  _s:name_init()
end

function Holo.member_init(_s)

  _s._mmbr = {

    sora    = {id = "UCp6993wxpyDPHUpavwDFqgg"},
    roboco  = {id = "UCDqI2jOz0weumE8s7paEk6g"},
    mel     = {id = "UCD8HOxPs4Xvsm8H0ZxXGiBw"},
    aki     = {id = "UCFTLzh12_nrtzqBPsTCqenA"},
    matsuri = {id = "UCQ0UDLQCjY0rmuxCDE38FGg"},
    ---[[
    fubuki  = {id = "UCdn5BQ06XqgXoAxIhbqw5Rg"},
    haato   = {id = "UC1CfXB_kRs3C-zaeTG3oGyg"},
    aqua    = {id = "UC1opHUrw8rvnsadT-iGp7Cg"},
    shion   = {id = "UCXTpFs_3PqI41qX2d9tL2Rw"},
    ayame   = {id = "UC7fk0CB07ly8oSl0aqKkqFg"},
    choco   = {id = "UC1suqwovbL1kzsoaZgFZLKg"},
    subaru  = {id = "UCvzGlP9oQwU--Y0r9id_jnA"},
    mio     = {id = "UCp-5t9SrOQwXMU7iIjQfARg"},
    miko    = {id = "UC-hM6YJuNYVAmUWxeIr9FeA"},
    okayu   = {id = "UCvaTdHTWBGv3MKj3KVqJVCw"},
    korone  = {id = "UChAnqc_AY5_I3Px5dig3X1Q"},
    azki    = {id = "UC0TXe_LYZ4scaW2XMyi5_kw"},
    suisei  = {id = "UC5CwaMl1eIgY8h02uZw7u8A"},
    pekora  = {id = "UC1DCedRgGHBdm81E1llLhOQ"},
    -- rushia  = {id = "UCl_gCybOJRIgOXw6Qb4qJzQ"},
    flare   = {id = "UCvInZx9h3jC2JzsIzoOebWg"},
    noel    = {id = "UCdyqAaZDKHXg4Ahi7VENThQ"},
    marine  = {id = "UCCzUftO8KOVkV4wQG1vkUvg"},
    kanata  = {id = "UCZlDXzGoo7d44bwdNObFacg"},
    watame  = {id = "UCqm3BQLlJfvkTsX_hvm0UmA"},
    towa    = {id = "UC1uv2Oq6kNxgATlCiez59hw"},
    luna    = {id = "UCa9Y57gfeY0Zro_noHRVrnw"},
    lamy    = {id = "UCFKOVgVbGmX65RxO3EtH3iw"},
    nene    = {id = "UCAWSyEs_Io8MtpY3m-zqILA"},
    botan   = {id = "UCUKD-uaobj9jiqB-VXt71mA"},
    polka   = {id = "UCK9V2B22uJYu3N7eR_BT9QA"},
    laplus  = {id = "UCENwRMx5Yh42zWpzURebzTw"},
    lui     = {id = "UCs9_O1tRPMQTHQ-N_L6FU2g"},
    koyori  = {id = "UC6eWCld0KwmyHFbAqK3V-Rw"},
    chloe   = {id = "UCIBY1ollUsauvVi4hW4cumw"},
    iroha   = {id = "UC_vMYWcDjmfdpH6r4TTn1MQ"},
    --]]
  }
end

function Holo.name_init(_s)

  _s._name = {}

  for name, tbl in pairs(_s._mmbr) do
    table.insert(_s._name, name)
  end
end

function Holo.member(_s)

  return _s._mmbr
end

function Holo.name(_s)

  return _s._name
end

function Holo.cnt(_s)

  _s:cnt_req()
  _s:name_srt()
  _s:prnt()
end

function Holo.cnt_req(_s)

  local api_key = api_key

  local ep      = "https://www.googleapis.com/youtube/v3/channels?"
  local prm_prt = "part".."=".."statistics"

  local id = {}
  for name, tbl in pairs(_s:member()) do
    table.insert(id, tbl.id)
  end
  local id_str = table.concat(id, ",")

  local prm = {
    prm_prt,
    "id" .."="..id_str ,
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

    cnt = tonumber(itm.statistics.subscriberCount) / 10000
    name = _s:name_by_id(itm.id)

    _s._mmbr[name].cnt = cnt
  end
end

function Holo.name_srt(_s)

  local cmpr = function(name1, name2)

    if _s._mmbr[name1].cnt == _s._mmbr[name2].cnt then
      return name1 < name2
    end

    return _s._mmbr[name1].cnt > _s._mmbr[name2].cnt
  end
  table.sort(_s._name, cmpr)
end

function Holo.name_by_id(_s, id)

  for name, tbl in pairs(_s:member()) do
    if tbl.id == id then return name end
  end
end

function Holo.prnt(_s)

  for idx, name in pairs(_s._name) do
    print(name, string.format("%5.1f", _s._mmbr[name].cnt))
  end
end

-- main

local holo = Holo.new()
holo:cnt()

