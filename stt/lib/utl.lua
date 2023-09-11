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

function Utl.cmd(cmd, op)
  -- u.log(cmd)
	op = op or "*a"

  local fp = io.popen(cmd)
	
  local rslt = fp:read(op)
  -- u.log(rslt)
	
  fp:close()

  return rslt
end

function Utl.cmd1(cmd)
	
	return Utl.cmd(cmd, "*l")
end

function Utl.cmd_2_tbl(cmd)
  -- u.log(cmd)

  local fp = io.popen(cmd)
	
	local r_tbl = {}
	
	for line in fp:lines() do
		
		ar.add(r_tbl, line)
	end
	
  fp:close()

  -- u.log(rslt)
  return r_tbl
end

function Utl.curl(ep, prm)

  local url = ep.."?"..table.concat(prm, "&")
  local cmd = "curl -s '"..url.."'"
  -- u.log(cmd)
  local jsn = Utl.cmd(cmd)
  -- u.log(jsn)
	
  -- local tbl = cjson.decode(jsn)
  local tbl = Utl.jsn_decode(jsn)
  return tbl
end

function Utl.jsn_decode(jsn)
	
	if jsn == "" then return {} end
	
  local tbl = cjson.decode(jsn)
	return tbl
end

function Utl.tbl_by_jsn_file(jsn_file)
	
	local jsn = Utl.file_read(jsn_file)
	
  local tbl = Utl.jsn_decode(jsn)
	
	return tbl
end

function Utl.jq(jsn)
	
	local file = Cfg.jsn.encode.tmp_file
	
	Utl.file_write(file, jsn)
	
	-- local cmd = "cat " .. file .. " | jq "
	local cmd = "cat " .. file .. " | jq 'to_entries|sort_by(.value.cdt)|reverse|from_entries'"
  -- u.log(cmd)
	
	jsn = Utl.cmd(cmd)
  -- u.log(jsn)
	
  return jsn
end

function Utl.ls(path_wild_card, op)
	
  local cmd = "ls "..op.." "..path_wild_card
	
	local file = Utl.cmd_2_tbl(cmd)
	
  return file
end

function Utl.ul(l_path_file, s_dir) -- scp
	
  local cmd = u.c("scp ", l_path_file, " ", Cfg.ul.host_dir, "/", s_dir, "/")
	
	local rslt = Utl.cmd(cmd)
  return rslt
end

function Utl.cp(path1, path2)
	
  local cmd = u.c("cp ", path1, " ", path2)
	
	local rslt = Utl.cmd(cmd)
  return rslt
end

function Utl.file_read(path_file)

  local fp = io.open(path_file, "r")

  local jsn = fp:read("*a")

  fp:close()

  return jsn
end

function Utl.file_write(path_file, txt)
	-- u.log(path_file)

  local fp = io.open(path_file, "w")
	
	fp:write(txt)

  fp:close()
end

function Utl.date()
	
  return Utl.date_t0()
end

function Utl.time()
	
  local cmd = u.c('date +"%H:%M"')
	
	local rslt = Utl.cmd1(cmd)
  return rslt
end

function Utl.datetime()
	
	local rslt = u.c(Utl.date(), ".", Utl.time())
  return rslt
end

function Utl.date_y(n)
	
  local cmd = u.c('date -v ', '-', n, 'd +"%Y-%m-%d"')
	
	local rslt = Utl.cmd1(cmd)
  return rslt
end

function Utl.date_y1()
	
	return Utl.date_y(1)
end

function Utl.date_y2()
	
	return Utl.date_y(2)
end

function Utl.date_y7()
	
	return Utl.date_y(7)
end

function Utl.date_t(n)
	
  local cmd = u.c('date -v ', '+', n, 'd +"%Y-%m-%d"')
	
	local rslt = Utl.cmd1(cmd)
  return rslt
end

function Utl.date_t0()
	
	return Utl.date_t(0)
	-- return Utl.date_y(0)
end

function Utl.date_t7()
	
	return Utl.date_t(7)
end

function Utl.basename(path)
	
  local cmd = 'basename '..path
	
	local rslt = Utl.cmd1(cmd)
  return rslt
end

function Utl.ext_del(file_name, ext)
	
	ext = ext or ".json"
	
	local idx1, idx2 = string.find(file_name, ext, 1, true)
	local r_str = string.sub(file_name, 1, idx1 - 1)
	return r_str
end

function Utl.str_mb_daku_crct(p_str)

	local mb_daku = {
		{'ガ', 'ガ'}, {'ギ', 'ギ'}, {'グ', 'グ'}, {'ゲ', 'ゲ'}, {'ゴ', 'ゴ'},
		{'ザ', 'ザ'}, {'ジ', 'ジ'}, {'ズ', 'ズ'}, {'ゼ', 'ゼ'}, {'ゾ', 'ゾ'},
		{'ダ', 'ダ'}, {'ヂ', 'ヂ'}, {'ヅ', 'ヅ'}, {'デ', 'デ'}, {'ド', 'ド'},
		{'バ', 'バ'}, {'ビ', 'ビ'}, {'ブ', 'ブ'}, {'ベ', 'ベ'}, {'ボ', 'ボ'},
		{'パ', 'パ'}, {'ピ', 'ピ'}, {'プ', 'プ'}, {'ペ', 'ペ'}, {'ポ', 'ポ'},
		{'ヴ', 'ヴ'},
		{'が', 'が'}, {'ぎ', 'ぎ'}, {'ぐ', 'ぐ'}, {'げ', 'げ'}, {'ご', 'ご'},
		{'ざ', 'ざ'}, {'じ', 'じ'}, {'ず', 'ず'}, {'ぜ', 'ぜ'}, {'ぞ', 'ぞ'},
		{'だ', 'だ'}, {'ぢ', 'ぢ'}, {'づ', 'づ'}, {'で', 'で'}, {'ど', 'ど'},
		{'ば', 'ば'}, {'び', 'び'}, {'ぶ', 'ぶ'}, {'べ', 'べ'}, {'ぼ', 'ぼ'},
		{'ぱ', 'ぱ'}, {'ぴ', 'ぴ'}, {'ぷ', 'ぷ'}, {'ぺ', 'ぺ'}, {'ぽ', 'ぽ'},
		{'ゔ', 'ゔ'},
	}

	local r_str = p_str
	for idx, _mb_daku in pairs(mb_daku) do

		r_str = string.gsub(r_str, _mb_daku[1], _mb_daku[2])
	end
	return r_str
end

function Utl.txt_2_tbl(txt)
end

u = Utl -- alias

function u.log(...)

  print(...)
end

function u.log_ar(ar)
	
	if type(ar) == "table" then
		
		for key, val in pairs(ar) do
			print(key, val)
		end
	else
		u.log(ar)
	end
end

function u.prnt(...) -- stdout

  print(...)
end

function u.c(...)
	
	local r_str = ""

  -- for idx, str in ... do
  for idx, str in pairs({...}) do
		
		r_str = r_str .. str
	end
	
	return r_str
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

function ar.add(ar1, val)
	
	table.insert(ar1, val)
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

function ar.clr(_ar)

	if not _ar then return end
	
  for key, val in pairs(_ar) do
    _ar[key] = nil
  end
end

