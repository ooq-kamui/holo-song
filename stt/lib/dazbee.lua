require("cfg")
require("utl")
require("ytube")

Dazbee = {}

Dazbee._cnst = {

  ch_id = "UCUEvXLdpCtbzzDkcMI96llg",
  song = {
    lst_id = {
      "PLguPqKADXoCFtJx2Xi2z4jMjzf9ZZxlPE", -- org
      "PLguPqKADXoCEw_vJqW0VSNTKejjUAk2wY", -- cvr
      "PLguPqKADXoCFzOk-Do2tlXE-EkkquCXKR", -- special
      "PLguPqKADXoCHL1WH7DkaaUlAXWUQc7syo", -- duet
    },
    lst_excld_video_id = {
			"19CVkddgXMo", -- anm
			"QF5Jkv0oHYA", -- clb-real
    },
  },
}
Dazbee._cfg = {
  dir_data = Cfg.prj.dir .. "/www/song/data/etc/dazbee",
}

function Dazbee.song_lst_id()

  local lst_id = {}
  local excld_video_id = {}

  ar.join(lst_id, Dazbee._cnst.song.lst_id)

  if Dazbee._cnst.song.lst_excld_video_id then
    ar.join(excld_video_id, Dazbee._cnst.song.lst_excld_video_id)
  end

  return lst_id, excld_video_id
end

function Dazbee.song_video()

  local video = {}
	
  if not Dazbee._cnst.song.video_id then return video end

  for idx, video_id in pairs(Dazbee._cnst.song.video_id) do

    video[video_id] = {}
  end

  return video
end

-- obj

function Dazbee.new()

  local obj = Utl.new(Dazbee)
  return obj
end

function Dazbee.init(_s)
end

--
-- video __
--

function Dazbee.video__init(_s)

  _s._video = {}
end

function Dazbee.video__(_s, video)

  _s._video = video
end

function Dazbee.video__by_jsn(_s, jsn)

  _s._video = cjson.decode(jsn)
end

function Dazbee.video__by_jsn_file(_s, path_jsn)

  local jsn = Utl.file_read(path_jsn)
  _s:video__by_jsn(jsn)
end

-- video view cnt

function Dazbee.video_view_cnt__(_s)

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
			
      _s._video[itm.id].title = itm.snippet.title
      _s._video[itm.id].cdt   = itm.snippet.publishedAt

      if itm.statistics.viewCount then
        _s._video[itm.id].view_cnt = tonumber(itm.statistics.viewCount)
      else
        _s._video[itm.id].view_cnt = -1 -- mmbr only
      end
    end
    idx_s = idx_s + lim
		
		-- break -- tst
  until idx_s > #video_id
end

function Dazbee.video_view_cnt__0(_s)
	
	for video_id, _video in pairs(_s._video) do
		_video.view_cnt = 0
	end
end

function Dazbee.video_id__init(_s)

	_s._video_id = {}
end

function Dazbee.video_id__(_s)
	
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

function Dazbee.video_id__clr(_s)
	
		ar.clr(_s._video_id)
end

function Dazbee.video_id__srt(_s, prp)
	
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

function Dazbee.video_srtd__(_s)
	
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

function Dazbee.video__song(_s)

  _s:video__init()

  _s:video__add_song()

  _s:video_view_cnt__()
end

function Dazbee.video__add_song(_s)

  _s:video__add_song_lst()
  _s:video__add_song_video()
end

function Dazbee.video__add_song_lst(_s)

  local lst_id, excld_video_id = Dazbee.song_lst_id()

  for idx, _lst_id in pairs(lst_id) do

    _s:video__add_by_lst_id(_lst_id, excld_video_id)
  end
end

function Dazbee.video__add_by_lst_id(_s, lst_id, excld_video_id)

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

function Dazbee.video__add_song_video(_s)

  ar.mrg(_s._video, Dazbee.song_video())
end

function Dazbee.video__excld(_s, excld_video_id)

  for idx, _excld_video_id in pairs(excld_video_id) do

    _s._video[_excld_video_id] = nil
  end
end

--
-- srch
--

function Dazbee.srch(_s, word) -- use not

  local video = {}

  for name, tbl in pairs(_s:mmbr("jp")) do
  
    _s:ch_srch(tbl.ch_id, word, video)
  end
  return video
end

function Dazbee.ch_srch(_s, ch_id, word, video)

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

function Dazbee.video_2_jsn_prnt(_s)
	
	local jsn = _s:video_2_jsn()
	
  u.prnt(jsn)
end

function Dazbee.video_2_jsn_write(_s, path_file)
	
	local jsn = _s:video_2_jsn()
	
  Utl.file_write(path_file, jsn)
end

function Dazbee.video_2_jsn(_s)

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

function Dazbee.video__add(_s, video2)

  if not _s._video then _s:video__init() end

  for video_id2, tbl2 in pairs(video2) do

    _s._video[video_id2] = tbl2
  end
end

--
-- sub
--

function Dazbee.video__sub(_s, video2)

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

function Dazbee.video__ch_by_term(_s, ch_id, fr_date, to_date)

  fr_date = fr_date or Utl.date_y7()
  to_date = to_date or Utl.date_t7()

  _s:video__init()

  -- u.log(ch_id, fr_date, to_date)
  _s:video__add_by_ch(ch_id, fr_date, to_date)
end

function Dazbee.video__add_by_ch(_s, ch_id, fr_date, to_date, excld_video_id)

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

function Dazbee.main_song_video(_s)
	
	_s:video__song_ttl_write()

	-- _s:video__song_ttl_ltst1_sub_ttl_ltst2_write()

	-- _s:song_video_data_rsync()
end

function Dazbee.video__song_ttl_write(_s)
	
	local path_song_ttl = Dazbee._cfg.dir_data.."/"..Utl.datetime()..".json"
	
	_s:video__song()

	_s:video_2_jsn_write(path_song_ttl)

	-- Utl.cp(path_song_ttl, Cfg.song_video.path_t_ltst)
end

function Dazbee.video__song_ttl_ltst1_sub_ttl_ltst2_write(_s)
	
	local path_jsn = _s:song_ttl_jsn_file_ltst()
	
	if #path_jsn < 2 then return end

	local video1 = Utl.tbl_by_jsn_file(path_jsn[1])
	local video2 = Utl.tbl_by_jsn_file(path_jsn[2])

	_s:video__(   video1)
	_s:video__sub(video2)

	local file_jsn1 = Utl.basename(path_jsn[1])
	local file_jsn2 = Utl.basename(path_jsn[2])

	local file_sub = Utl.ext_del(file_jsn1)..".-."..file_jsn2
	local path_sub = Dazbee._cfg.dir_data.."/"..file_sub

	_s:video_2_jsn_write(path_sub)

	-- Utl.cp(path_sub, Cfg.song_video.path_s_ltst)
end

function Dazbee.song_ttl_jsn_file_ltst(_s)
	
	local path_wc  = Dazbee._cfg.dir_data.."/????-??-??.??:??.json"
	local path_jsn = Utl.ls(path_wc, "-r")
	-- u.log_ar(path_jsn)
	
	return path_jsn
end

function Dazbee.song_video_data_rsync(_s)
	
	Utl.cmd("fish rsync.data.song_video.fish")
end

