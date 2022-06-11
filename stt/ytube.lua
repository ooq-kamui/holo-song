
Ytube = {
  api_key = require("ytube-data-api-key"),
  ep_base = "https://www.googleapis.com/youtube/v3/",
}

function Ytube.video_view_cnt(video_id, idx_s)

  local trgt = "videos"
  local idx_e = video_id[idx_s + 49] and (idx_s + 49) or #video_id
  local prm = {
    "key" .."="..Ytube.api_key,
    "part".."=".."statistics,snippet",
    "id"  .."="..table.concat(video_id, ",", idx_s, idx_e),
  }
  local res = Ytube.curl(trgt, prm)
  return res
end

function Ytube.video_by_lst(lst_id, pgtkn)

  local trgt = "playlistItems"
  local prm = {
    "key"       .."="..Ytube.api_key,
    "part"      .."=".."snippet",
    "playlistId".."="..lst_id,
    "maxResults".."=".."50",
  }
  if pgtkn then table.insert(prm, "pageToken" .."="..pgtkn) end

  local res = Ytube.curl(trgt, prm)
  -- u.log(lst_id)
  -- u.log(res)
  return res
end

function Ytube.video_by_ch(ch_id, year, pgtkn)

  local trgt = "search"

  ch_id = ch_id or ""

  year = year or 2022
  local fr = year.."-06-04T00:00:00Z"
  -- local fr = year.."-01-01T00:00:00Z"
  local to = year.."-12-31T23:59:59Z"

  local prm = {
    "key"       .."="..Ytube.api_key,
    "part"      .."=".."id",
    "channelId" .."="..ch_id,
    "publishedAfter" .."="..fr,
    "publishedBefore".."="..to,
    "maxResults".."=".."50",
    -- "order"     .."=".."viewCount",
    "type"      .."=".."video",
  }
  if pgtkn then table.insert(prm, "pageToken" .."="..pgtkn) end

  local res = Ytube.curl(trgt, prm)
  return res
end

function Ytube.srch(ch_id, word)

  local trgt = "search"
  local prm = {
    "key"       .."="..Ytube.api_key,
    "part"      .."=".."id",
    "channelId" .."="..ch_id,
    "maxResults".."=".."50",
    "order"     .."=".."viewCount",
    "q"         .."="..word,
    "type"      .."=".."video",
  }
  local res = Ytube.curl(trgt, prm)
  return res
end

function Ytube.curl(trgt, prm)

  local ep  = Ytube.ep_base..trgt
  local res = Utl.curl(ep, prm)
  return res
end

