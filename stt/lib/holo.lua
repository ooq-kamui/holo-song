require("cfg")
require("utl")
require("ytube")

Holo = {}

require("holo_cnst")

function Holo.new()

  local obj = Utl.new(Holo)
  return obj
end

function Holo.init(_s)

  _s:name_ordr_init()
end

function Holo.name_ordr_init(_s)

  --[[
  _s._name_ordr = {}

  for name, tbl in pairs(Holo._jp.mmbr) do
    table.insert(_s._name_ordr, name)
  end
  --]]
end

function Holo.name_ordr(_s)

  return _s._name_ordr
end

--
-- video __
--

function Holo.video__init(_s)

  _s._video = {}
end

function Holo.video__(_s, video)

  _s._video = video
end

function Holo.video__by_jsn(_s, jsn)

  _s._video = cjson.decode(jsn)
end

function Holo.video__by_jsn_file(_s, path_jsn)

  local jsn = Utl.file_read(path_jsn)
  _s:video__by_jsn(jsn)
end

-- video view cnt

function Holo.video___dtl(_s)
end

function Holo.video_view_cnt__(_s)

  local video_id = ar.key(_s._video)
  local res
	local lim = 50
  local idx_s = 1
  repeat
    res = Ytube.video_view_cnt(video_id, idx_s)

    if res.error then
			Ytube.log_err(res.error)
			break
		end

    for idx, itm in pairs(res.items) do
      
      -- _s._video[itm.id].title = itm.snippet.title
      _s._video[itm.id].title = Utl.str_mb_daku_crct(itm.snippet.title)

      _s._video[itm.id].cdt   = itm.snippet.publishedAt
      
      -- localization en
      -- tst
      -- u.log_ar(itm.localizations)
      if itm.localizations then
        if itm.localizations.en then
          -- u.log_ar(itm.localizations.en.title)
          _s._video[itm.id].title_en = itm.localizations.en.title
        end
      end

      if itm.statistics.viewCount then
        _s._video[itm.id].view_cnt = tonumber(itm.statistics.viewCount)
      else
        _s._video[itm.id].view_cnt = -1 -- mmbr only
      end
    end
    idx_s = idx_s + lim
    
  until idx_s > #video_id
end

function Holo.video_view_cnt__0(_s) -- use not
	
	for video_id, _video in pairs(_s._video) do
		_video.view_cnt = 0
	end
end

function Holo.video_id__init(_s)

	_s._video_id = {}
end

function Holo.video_id__(_s)
	
	if not _s._video then return end
	
	if not _s._video_id then
		_s:video_id__init()
	else
		_s:video_id__clr()
	end
	
	for video_id, tbl in pairs(_s._video) do
		
		ar.add(_s._video_id, video_id)
	end
end

function Holo.video_id__clr(_s)
	
		ar.clr(_s._video_id)
end

function Holo.video_id__srt(_s, prp)
	
	prp = prp or "cdt"
	
  local cmpr = function(video_id1, video_id2)

		-- u.log("v1:"..video_id1)
		-- u.log_ar(_s._video[video_id1])
		-- u.log("v2:"..video_id2)
		-- u.log_ar(_s._video[video_id2])
		
    if not _s._video[video_id1][prp] or not _s._video[video_id2][prp] then
      return video_id1 < video_id2
			
		elseif _s._video[video_id1][prp] == _s._video[video_id2][prp] then
      return video_id1 < video_id2
		else
			return _s._video[video_id1][prp] < _s._video[video_id2][prp]
    end
  end
	
  table.sort(_s._video_id, cmpr)
end

function Holo.video_srtd__(_s)
	
	_s:video_id__()
	
	_s:video_id__srt()
	
	_s._video_srtd = {}
	
	for idx, _video_id in pairs(_s._video_id) do
		-- u.log(_video_id)
		
		_s._video_srtd[_video_id] = _s._video[_video_id]
	end
end

--
-- song
--

function Holo.video__song(_s, cntry)

  _s:video__init()

  for key, _cntry in pairs(cntry) do

    _s:video__add_song(_cntry, "ofcl")
    _s:video__add_song(_cntry, "mmbr")
  end

  _s:video__excld(Holo.song_excld_video_id())

  _s:video_view_cnt__()
end

function Holo.video__add_song(_s, cntry, cls)

  _s:video__add_song_lst(  cntry, cls)
  _s:video__add_song_video(cntry, cls)
end

function Holo.video__add_song_lst(_s, cntry, cls)

  local lst_id, excld_video_id = _s:song_lst_id(cntry, cls)

  for idx, _lst_id in pairs(lst_id) do

    _s:video__add_by_lst_id(_lst_id, excld_video_id)
  end
end

function Holo.video__add_by_lst_id(_s, lst_id, excld_video_id)

  local res, pgtkn_nxt, video_id
  repeat
    res = Ytube.video_by_lst(lst_id, pgtkn_nxt)

    if res.error then
      Ytube.log_err(res.error)
      break
    end

    for idx, itm in pairs(res.items) do

      video_id = itm.snippet.resourceId.videoId

      if ar.in_(video_id, excld_video_id) then
        -- nothing
      else
        _s._video[video_id] = {}
      end
    end

    pgtkn_nxt = res.nextPageToken
  until not pgtkn_nxt
end

function Holo.video__add_song_video(_s, cntry, cls)

  ar.mrg(_s._video, _s:song_video(cntry, cls))
end

function Holo.video__excld(_s, excld_video_id)

  for idx, _excld_video_id in pairs(excld_video_id) do

    _s._video[_excld_video_id] = nil
  end
end

--
-- srch
--

function Holo.srch(_s, word) -- use not

  local video = {}

  for name, tbl in pairs(_s:mmbr("jp")) do
  
    _s:ch_srch(tbl.ch_id, word, video)
  end
  return video
end

function Holo.ch_srch(_s, ch_id, word, video)

  local res = Ytube.srch(ch_id, word)

  if not video then video = {} end

  for idx, itm in pairs(res.items) do

    video[itm.id.videoId] = {}
  end

  return video
end

--
-- output
--

function Holo.video_2_jsn_prnt(_s)
	
	local jsn = _s:video_2_jsn()
	
	u.prnt(jsn)
end

function Holo.video_2_jsn_write(_s, path_file)
	
	local jsn = _s:video_2_jsn()
	
	Utl.file_write(path_file, jsn)
end

function Holo.video_2_jsn(_s)

	local t_video
	
	-- if false then -- srt
	if true then -- srt
		_s:video_srtd__()
		t_video = _s._video_srtd
	else
		t_video = _s._video
	end
	
  local jsn = cjson.encode(t_video)
	jsn = Utl.jq(jsn)
  -- u.log(jsn) -- stdout
	return jsn
end

--
-- add
--

function Holo.video__add(_s, video2)

  if not _s._video then _s:video__init() end

  for video_id2, tbl2 in pairs(video2) do

    _s._video[video_id2] = tbl2
  end
end

--
-- sub
--

function Holo.video__sub(_s, video2)

  local tbl2
  for video_id, tbl1 in pairs(_s._video) do

    tbl2 = video2[video_id]

    if not tbl1.view_cnt
    or tbl1.view_cnt == -1 -- mmbr only
    or tbl1.view_cnt ==  0 -- rls pre
    then
      _s._video[video_id] = nil
    else
      if tbl2 and tbl2.view_cnt and tbl2.view_cnt ~= 0 then

        tbl1.view_cnt = tbl1.view_cnt - tbl2.view_cnt
      else
        tbl1.new = true
      end
    end
  end
end

--
-- ch
--

function Holo.video__ch_by_term(_s, ch_id, fr_date, to_date)

  fr_date = fr_date or Utl.date_y7()
  to_date = to_date or Utl.date_t7()

  _s:video__init()

  -- u.log(ch_id, fr_date, to_date)
  _s:video__add_by_ch(ch_id, fr_date, to_date)
end

function Holo.video__add_by_ch(_s, ch_id, fr_date, to_date, excld_video_id)

  excld_video_id = excld_video_id or {}

  local res, pgtkn_nxt, video_id
  repeat
    res = Ytube.video_by_ch(ch_id, fr_date, to_date, pgtkn_nxt)

    if res.error then
			Ytube.log_err(res.error)
			break
		end

    for idx, itm in pairs(res.items) do

      video_id = itm.id.videoId

      if ar.in_(video_id, excld_video_id) then
        -- nothing
      else
        _s._video[video_id] = {}
        _s._video[video_id].title    = itm.snippet.title
        _s._video[video_id].cdt      = itm.snippet.publishedAt or ""
        _s._video[video_id].view_cnt = 0
      end
    end

    pgtkn_nxt = res.nextPageToken
  until not pgtkn_nxt
end

-- 
-- song_video main
-- 

function Holo.main_song_video(_s)
  
  _s:video__song_ttl_write()

  _s:video__song_ttl_ltst1_sub_ttl_ltst2_write()

  _s:song_video_data_rsync()
end

function Holo.main_song_video_dbg(_s)
  
  local is_by_jsn = true -- dbg
  
  if is_by_jsn then
    
    local path_song_ttl = _s:song_ttl_jsn_file_ltst()[1]
    _s:video__by_jsn_file(path_song_ttl)
    
    -- dbg tst
    -- _s:video_view_cnt__()
    -- _s:video_2_jsn_write("a.json")
  else
    _s:video__song_ttl_write()
  end

  -- _s:video__song_ttl_ltst1_sub_ttl_ltst2_write()

	-- _s:song_video_data_rsync()
end

function Holo.video__song_ttl_write(_s)
  
  local path_song_ttl = Cfg.song_video.dir_data.."/"..Utl.datetime()..".json"
  
  _s:video__song({"jp", "en", "id"})

  _s:video_2_jsn_write(path_song_ttl)

	Utl.cp(path_song_ttl, Cfg.song_video.path_t_ltst)
end

function Holo.video__song_ttl_ltst1_sub_ttl_ltst2_write(_s)
	
	local path_jsn = _s:song_ttl_jsn_file_ltst()
	
	if #path_jsn < 2 then return end

	local video1 = Utl.tbl_by_jsn_file(path_jsn[1])
	local video2 = Utl.tbl_by_jsn_file(path_jsn[2])

	_s:video__(   video1)
	_s:video__sub(video2)

	local file_jsn1 = Utl.basename(path_jsn[1])
	local file_jsn2 = Utl.basename(path_jsn[2])

	local file_sub = Utl.ext_del(file_jsn1)..".-."..file_jsn2
	local path_sub = Cfg.song_video.dir_data.."/"..file_sub

	_s:video_2_jsn_write(path_sub)

	Utl.cp(path_sub, Cfg.song_video.path_s_ltst)
end

function Holo.song_ttl_jsn_file_ltst(_s)
	
	local path_wc  = Cfg.song_video.dir_data.."/????-??-??.??:??.json"
	local path_jsn = Utl.ls(path_wc, "-r")
	-- u.log_ar(path_jsn)
	
	return path_jsn
end

function Holo.song_video_data_rsync(_s)
	
	Utl.cmd("fish rsync.data.song_video.fish")
end

-- 
-- ch_video main
-- 

function Holo.main_ch_video(_s)
	
	_s._cntry = "jp"
	
	-- local fr_date = Utl.date_y(7) -- tst
	local fr_date = Utl.date_y2()
	local to_date = Utl.date_t0()
	
	_s:video__ch_ttl_add_term_write(fr_date, to_date)
	
	_s:ch_video_data_rsync()
end

function Holo.video__ch_ttl_add_term_write(_s, fr_date, to_date)
	
	local mmbr = _s:mmbr(_s._cntry)

	for name, tbl in pairs(mmbr) do
		u.log(name)
		
		_s:video__ch_by_term_write(name, fr_date, to_date)
		
		_s:video__ttl_add_term_write(name, fr_date, to_date)
	end
end

function Holo.video__ch_by_term_write(_s, name, fr_date, to_date)
	
	local ch_id = Holo["_".._s._cntry].mmbr[name].ch_id
	_s:video__ch_by_term(ch_id, fr_date) -- to_date = nil
	
	local path_term_jsn = _s:ch_video_path_term_jsn(name, fr_date, to_date)
	_s:video_2_jsn_write(path_term_jsn)
	-- u.log(path_term_jsn)
end

function Holo.video__ttl_add_term_write(_s, name, fr_date, to_date)

	local path_name_jsn     = _s:ch_video_path_name_jsn(name)
	local path_name_jsn_old = _s:ch_video_path_name_jsn_old(name)
	
	_s:video__by_jsn_file(path_name_jsn)
	-- _s:video__by_jsn_file(path_name_jsn_old)
	
	local path_term_jsn = _s:ch_video_path_term_jsn(name, fr_date, to_date)
	local video2 = Utl.tbl_by_jsn_file(path_term_jsn)
	_s:video__add(video2)
	
	local path_ttl_jsn = _s:ch_video_path_ttl_jsn(name)
	_s:video_2_jsn_write(path_ttl_jsn)
	
	Utl.cp(path_ttl_jsn, path_name_jsn)
end

function Holo.ch_video_data_rsync(_s)

	Utl.cmd("fish rsync.data.ch_video.fish")
end

function Holo.ch_video_dir_name(_s, name)
	
	local dir_name = u.c(Cfg.ch_video.dir_data, "/", name)
	return dir_name
end

function Holo.ch_video_path_name_jsn_old(_s, name)

	local dir_name = _s:ch_video_dir_name(name)
	local path_name_jsn = dir_name.."/"..name..".json"
	return path_name_jsn
end

function Holo.ch_video_path_name_jsn(_s, name)

	local dir_name = _s:ch_video_dir_name(name)
	local path_name_jsn = dir_name.."/ltst.json"
	return path_name_jsn
end

function Holo.ch_video_path_term_jsn(_s, name, fr_date, to_date)
	
	local term = fr_date..".-."..to_date
	
	local dir_name = _s:ch_video_dir_name(name)
	local dir_term = dir_name.."/add" -- mod add > term
	local path_term_jsn = dir_term.."/"..name.."."..term..".json"
	return path_term_jsn
end
	
function Holo.ch_video_path_ttl_jsn(_s, name)
	
	local dir_name = _s:ch_video_dir_name(name)
	local dir_ttl  = dir_name.."/ttl"
	local path_ttl_jsn = dir_ttl.."/"..name.."."..Utl.date()..".json"
	return path_ttl_jsn
end

