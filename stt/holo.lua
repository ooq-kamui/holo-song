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

function Holo.ch_reg_cnt(_s)
end

--
-- video __
--

function Holo.video__init(_s)

  _s._video = {}
end

function Holo.video__jsn_file(_s, jsn_file)

  local jsn = Utl.file_read(jsn_file)
  _s:video__by_jsn(jsn)
end

function Holo.video__by_jsn(_s, jsn)

  _s._video = cjson.decode(jsn)
end

function Holo.video__(_s, video)

  _s._video = video
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

function Holo.video_view_srt(_s)
end

--
-- song
--

function Holo.video__song_view_cnt(_s, cntry)

  _s:video__init()

  for key, _cntry in pairs(cntry) do

    _s:video__add_song(_cntry, "ofcl")
    _s:video__add_song(_cntry, "mmbr")
  end

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

--
-- srch
--

function Holo.srch(_s, word)

  local video = {}

  for name, tbl in pairs(_s:mmbr()) do
  
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

function Holo.video_2_jsn(_s)

  local to_jsn = {}
  local _to_jsn

  local jsn = cjson.encode(_s._video)
  u.log(jsn) -- stdout
end

function Holo.video_view_cnt_2_txt(_s)

  if not _s._video then return end

  local row

  for video_id, tbl in pairs(_s._video) do

    if tbl.view_cnt then

      row = {
        tbl.cdt,
        video_id,
        string.format("%8.0f", tbl.view_cnt),
        tbl.title,
      }
      u.log(table.concat(row, " "))
     end
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

function Holo.video__by_ch(_s, ch_id)

  _s:video__init()

  for year = 2017, 2022 do
    _s:video__add_by_ch(ch_id, year)
  end

  _s:video__view_cnt()
end

function Holo.video__add_by_ch(_s, ch_id, year, excld_video_id)

  excld_video_id = excld_video_id or {}

  local res, pgtkn_nxt, video_id
  repeat
    res = Ytube.video_by_ch(ch_id, year, pgtkn_nxt)

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

