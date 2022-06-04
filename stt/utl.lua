cjson = require("cjson")

Utl = {}

function Utl.new(Cls)

  local obj = {}
  for name, fnc in pairs(Cls) do
    if type(fnc) == "function" then obj[name] = fnc end
  end

  if obj.init then obj:init() end

  return obj
end

function Utl.curl(ep, prm)

  local url = ep.."?"..table.concat(prm, "&")
  local cmd = "curl -s '"..url.."'"
  local jsn = Utl.cmd(cmd)
  u.log(jsn)
  -- u.log(jsn)
  local tbl = cjson.decode(jsn)
  return tbl
end

function Utl.cmd(cmd)
  -- u.log(cmd)

  local hndl = io.popen(cmd)
  local rslt = hndl:read("*a")
  hndl:close()

  -- u.log(rslt)
  return rslt
end

function Utl.file_read(path_file)

  local fp = io.open(path_file, "r")

  local jsn = fp:read("*a")

  fp:close()

  return jsn
end

-- alias
u = Utl

function u.log(...)

  print(...)
end

-- ar

ar = {}

function ar.key(ar)

  local key = {}

  for _key, val in pairs(ar) do
    table.insert(key, _key)
  end
  return key
end

function ar.in_(_val, ar)

  local ret = false

  for key, val in pairs(ar) do

    if val == _val then ret = true break end
  end
  return ret
end

function ar.join(ar1, ar2)

  for idx, val in pairs(ar2) do
    table.insert(ar1, val)
  end
end

function ar.mrg(ar1, ar2)

  for key, val in pairs(ar2) do
    ar1[key] = val
  end
end

--[[
function Utl.ar_ofst(_ar, _idx, num)

  local ar = {}

  if not ar[_idx] then return end

  for idx, val in pairs(_ar) do

  end

  return ar
end
--]]


