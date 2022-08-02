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

function Holo.video__by_jsn_file(_s, jsn_file)

  local jsn = Utl.file_read(jsn_file)
  _s:video__by_jsn(jsn)
end

-- video view cnt

function Holo.video__view_cnt(_s)

  local video_id = ar.key(_s._video)
  local res
  local idx_s = 1
  repeat
    res = Ytube.video_view_cnt(video_id, idx_s)

    if res.error then u.log("err") return end

    for idx, itm in pairs(res.items) do

      _s._video[itm.id].title = itm.snippet.title
      _s._video[itm.id].cdt   = itm.snippet.publishedAt

      if itm.statistics.viewCount then
        _s._video[itm.id].view_cnt = tonumber(itm.statistics.viewCount) -- / 10000
      else
        _s._video[itm.id].view_cnt = -1 -- mmbr only
      end
    end

    idx_s = idx_s + 50
  until idx_s > #video_id
end

function Holo.video_id__(_s)
	
	if not _s._video then return end
	
	if not _s._video_id then
		_s._video_id = {}
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
	
	if not _s._video_id then
		_s:video_id__()
	end
	
  local cmpr = function(video_id1, video_id2)

    if _s._video[video_id1][prp] == _s._video[video_id2][prp] then
      return video_id1 < video_id2
		else
			return _s._video[video_id1].cdt < _s._video[video_id2].cdt
    end
  end
	
  table.sort(_s._video_id, cmpr)
end

function Holo.video_srtd__(_s)
	
	_s:video_id__srt()
	
	_s._video_srtd = {}
	
	for idx, _video_id in pairs(_s._video_id) do
		
		ar.add(_s._video_srtd, _s._video[_video_id])
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

  _s:video__view_cnt()
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

    if res.error then break end

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

function Holo.video__by_ch(_s, ch_id, fr_date)

  fr_date = fr_date or "2022-06-01"
  local to_date = "2022-12-31"

  _s:video__init()

  -- u.log(ch_id, fr_date, to_date)
  _s:video__add_by_ch(ch_id, fr_date, to_date)

  _s:video__view_cnt()
end

function Holo.video__add_by_ch(_s, ch_id, fr_date, to_date, excld_video_id)

  excld_video_id = excld_video_id or {}

  local res, pgtkn_nxt, video_id
  repeat
    res = Ytube.video_by_ch(ch_id, fr_date, to_date, pgtkn_nxt)

    if res.error then break end

    for idx, itm in pairs(res.items) do

      video_id = itm.id.videoId

      if ar.in_(video_id, excld_video_id) then
        -- nothing
      else
        _s._video[video_id] = {}
      end
    end

    pgtkn_nxt = res.nextPageToken
  until not pgtkn_nxt
end

