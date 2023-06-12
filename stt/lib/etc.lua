require("cfg")
require("utl")
require("ytube")

Etc = {}

Etc._cnst = {

	dazbee = {
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
				"cRm7xQ7MEEI", -- clb
				"pQF18US2tpk", -- clb
				"RATcPb1D_X4", -- clb
				"1vsJydi9BSs", -- clb
				"BacusC8zGqY", -- clb
				"oGyC1tffbv4", -- clb
				"2DDJcLtGuLA", -- trailer
			},
			video_id = {
				"L-Hl9uQWHPE", -- clb
			},
		},
	},
	inuitoko = {
		ch_id = "UCXRlIK3Cw_TJIQC5kSJJQMg",
		song = {
			lst_id = {
				"PLRGzS-dvI7Zz0AuAqnv0yo9bZSIQHutwt", -- all
			},
			lst_excld_video_id = {
			},
		},
	},
	vwp = {
		ch_id = "UCfiSo8tO3WPU-8YOgr4Ba6g",
		song = {
			lst_id = {
				"PLPqVb_3u9vSOXd5W4xU6SdRQH566UOIHs", -- kaf          - cvr
				"PLPqVb_3u9vSPmC_LA5IbAxVsxcJ2YZWwg", -- kaf          - org
				"PLPqVb_3u9vSP-sTicxVavDDoMHtujX7u9", -- kaf          - clb
				"PL2JAJdZbZxxBGn9Cr4L8O2M2u9a_qqtB4", -- rim          - cvr
				"PL2JAJdZbZxxAg-u96NH-rSXH-TU59vAAn", -- rim          - org
				"PLEmd18ijO3gTDOL1E_e6OmNfmwU-BzaPu", -- harusaruhi   - cvr
				"PLEmd18ijO3gSyA3lngsFXmm9wE3jXQplY", -- harusaruhi   - org
				"PL_Y0U3KlPL0dmpNS5ewVWmxOmmWobj0zU", -- isekaijoucho - cvr
				"PL_Y0U3KlPL0c_GRDoMbZsWlBNEoSb10Hh", -- isekaijoucho - org
				"PL_Y0U3KlPL0dz_yBRLuOzdTeTSSSSJbM9", -- isekaijoucho - clb
				"PLGmIA5WXg5Ll5lX6ur923ME1SrLobL_dm", -- koko         - cvr
				"PLGmIA5WXg5LmN-hr7TKH97hU9CIL1_gov", -- koko         - org
			},
			lst_excld_video_id = {
				"6QIEK5NbEAY", -- netflix
			},
		},
	},
	aru = {
		ch_id = "UC4mTp4T_DkmnFuhAlqNBnHA",
		song = {
			lst_id = {
				"PLCIhWJ4xPr0rRMgu9Am1GJHMAsZ428lek", -- cvr
				"PLCIhWJ4xPr0oqt1c0Xd2A3r5HYAPRFquK", -- org
				"PLCIhWJ4xPr0qkVzQZUZCgE-wVCJ3jQun4", -- clb
			},
			lst_excld_video_id = {
			},
		},
	},
	asu = {
		ch_id = "",
		song = {
			lst_id = {
				"PLSofePVD7pz_xrJBZZcyI9sTnnasy1Hih", -- cvr
				"PLSofePVD7pz-PBt-FCgydZhG45sakLoVs", -- org
				"PLSofePVD7pz-DPZSkm6WfkCSkxPknRp1j", -- clb
			},
			lst_excld_video_id = {
			},
		},
	},
	kano = {
		ch_id = "UCShXNLMXCfstmWKH_q86B8w",
		song = {
			lst_id = {
				"PLBQuo9fQ-4eMX8TSweBQhoduIPt6wEnHI", -- cvr
				"PLBQuo9fQ-4ePammIzWmZc7uPQc2cN8SWA", -- org
				"PLBQuo9fQ-4eNkTEBDV99M2K_D6Pf10YV3", -- unit
				-- "PLBQuo9fQ-4ePbM2oJFWz_y0WUhXRAEV9E", -- clb
			},
			lst_excld_video_id = {
			},
		},
	},
	lon = {
		ch_id = "UCSuVf5hodNJftAv0Zio-vXA",
		song = {
			lst_id = {
				"PLqGR5UqQJjyP6ImIWsq1teEtKBTbqYTtt", -- org, cvr
				"PLqGR5UqQJjyO-XFRyVFHx9yi42xPRb7O3", -- unit
			},
			lst_excld_video_id = {
				"ZlkJwuX_otM" -- 
			},
		},
	},
	vesperbell = {
		ch_id = "UCPd0Z22gF43dUidPYEQO5-w",
		song = {
			lst_id = {
				"PLu4d2yplfpFeh4H02ja12apUR3MgPYhND", -- all
			},
			lst_excld_video_id = {
			},
		},
	},
	hachi = {
		ch_id = "UC7XCjKxBEct0uAukpQXNFPw",
		song = {
			lst_id = {
				"PLwW-jiBMC59iewtUTK-P8utZSnGbMBT_r", -- org
				"PLwW-jiBMC59hr_8Bwp14LDeDk7SNOPmo_", -- cvr
				"PLwW-jiBMC59jNGDsZXOuqhaR2__HAN_gC", -- cvr-clb
				"PLwW-jiBMC59hPV-vZQn5FllMWAmvOQ5CT", -- org-clb
			},
			lst_excld_video_id = {
				"6rwIfgin12g", -- 
			},
		},
	},
	hanabasami = {
		ch_id = "UC4OeUf_KfYRrwksschtRYow",
		song = {
			lst_id = {
				"PLxujgzR9TjoOM5w1fMo5g1rDKK1gdTXRS", -- org
				"PLxujgzR9TjoNzy4qu3G6UFOPyFVc_Zerc", -- cvr
			},
			lst_excld_video_id = {
			},
		},
	},
	himehina = {
		ch_id = "UCFv2z4iM5vHrS8bZPq4fHQQ",
		song = {
			lst_id = {
				"PL1tX8zAv8bPk5fj3uFBgcOUHtlyAYKZBo", -- cvr
				"PL1tX8zAv8bPma-l8XNdpmGVvfiJIbvrZi", -- org
			},
			lst_excld_video_id = {
			},
		},
	},
	riot = {
		ch_id = "UCgmlcscaWprxYw0hta4JQuQ",
		song = {
			lst_id = {
				-- cocoa
				'PL8yYW3zN2w8KSD8W5vv2O7Vj_yE34Bizu', -- org
				'PL8yYW3zN2w8K183O6N4PI5jlUF50mI_P9', -- cvr
				-- iori
				'PLEA7t4ZaBOyRVAvdKumS2DwLONoD0YtC-', -- org
				'PLEA7t4ZaBOyS99fQGN0vE1IIy0_RcYG5Y', -- cvr
				'PLEA7t4ZaBOySCj2EsnUsR5fc_NVITbXIN', -- clb
				-- yuka
				'PL52mQEfscnrS4O_Qx64SVDYFqDwQTEkmQ', -- org
				'PL52mQEfscnrQPUGHnLBPG7vdyiOKPoNX8', -- cvr
				'PL52mQEfscnrTPSsNQzQkb0pTgdsbI72St', -- cvr
				-- suzuna
				'PLPJAhEd_ipmBGM9v041KDOYd9wBfQCd8A', -- org
				'PLPJAhEd_ipmBAjp3XsU1JPWQJpjeHm4kM', -- cvr
				-- miona
				-- 'PL7l66mvLmelBbBEE26oXPubSAkOvzJfJy', -- org
				-- 'PL7l66mvLmelD09A6zsKKlOB-M84I-4iWh', -- cvr
				-- meteopolis
				-- 'PLPJAhEd_ipmDm0omMiGZBqJMjteizS5dB',
			},
			lst_excld_video_id = {
				-- iori
				'gB99iD1urig', -- live
				'aI-IfsQbOKU', -- live
				'5V427kFmjyI', -- live
				'I6Njces23FE', -- live
				'h2QDa1gm3hg', -- live
				'VNhwqIYQ7XA', -- live
			},
		},
	},
	lucia = {
		ch_id = "UCBwH091x3pYLbGYwRtPbLlA",
		song = {
			lst_id = {
				"PLg6XDNQDetpqMYGl-wOtw_iKW4N7eFPrr", -- org
				"PLg6XDNQDetppnwEWDYlYXhoc9r9YQYIXG", -- cvr
			},
			lst_excld_video_id = {
				"37vSW-Q8YnQ", -- teaser
				"pd7H0nDN_us", -- teaser
			},
		},
	},
	pmaru = {
		ch_id = "UCLqCmbd6bgcLaBVz3aA-68A",
		song = {
			lst_id = {
				"PLcC3MjGnFuZvAzsJvZ67VPidd699dtmgM", -- org
				"PLcC3MjGnFuZtl5KkfXONu9dQMkXLKPhS5", -- cvr
			},
			lst_excld_video_id = {
			},
		},
	},
	ado = {
		ch_id = "UCln9P4Qm3-EAY4aiEPmRwEA",
		song = {
			lst_id = {
				"PLaxauk3chSWjJUBirUlCQH9fOgvfiNjcc", -- cvr
				"PLaxauk3chSWgwI1W0yo5Bv9GAn1O1cwKB", -- org
				-- "PLaxauk3chSWhFY96tRGKJlWpTWwCb_b2M", -- org - uta
			},
			lst_excld_video_id = {
			},
		},
	},
	hanatan = {
		ch_id = "UC8aUF9ipzQb2jTHlFoFZ1Vg",
		song = {
			lst_id = {
				"PL7Miy6hSyIrTe-rVOCP0H98rG7B34ugrG",
				"PL7Miy6hSyIrSimxrq6X-AbdC9UAMKgqUf",
				"PL7Miy6hSyIrT2d_-NkD4xvAQ2o0NG9dI8",
				"PL7Miy6hSyIrTJPfVbdt86Bqw5H4trIcKQ",
			},
			lst_excld_video_id = {
			},
		},
	},
	waka100 = {
		ch_id = "UC8isYJEcM_M7LOkJDodG-rg",
		song = {
			lst_id = {
				"PLuoIEgeIX7y7OEcBNuhNNkCic8snzKrei",
			},
			lst_excld_video_id = {
			},
		},
	},
	switchindie = {
		ch_id = "UCkH3CcMfqww9RsZvPRPkAJA",
		song = {
			lst_id = {
				"PLPh3p_yYrx0BPcWGA1uZ51w8fmmBlJWGs", -- 2018-05-11
				"PLPh3p_yYrx0DB3bdLdPmDYCCi4XBZBFAB", -- 2018-12-27
				"PLPh3p_yYrx0AlwkqPepl904VtvnY0Euiz", -- 2019-12-11
				"PLPh3p_yYrx0Dhlxx_hhQWX4d_Mli7Sxl_", -- 2020-12-16
				"PLPh3p_yYrx0BSuqPrQm2e87mGAMN7WBRG", -- 2021-04-15
				"PLPh3p_yYrx0DWoaz_DRnXn8XEw5TZEokI", -- 2021-12-16
				"PLPh3p_yYrx0AdabHG-gGzu8mE_ECLYp_9", -- 2022-05-11
				"PLPh3p_yYrx0DUuR7ASyt3OQ7pPfL_7gog", -- 2022-11-10
			},
			lst_excld_video_id = { -- main video
				"9Fw_wC2amlc", -- 2018-05-11
				"kF7JDSFnIe4", -- 2018-12-27
				"Sjosqi8m2iI", -- 2019-12-11
				"nsDmFKxtlLQ", -- 2020-12-16
				"8WteKv9ScIY", -- 2021-04-15
				"-7oS4zL04jc", -- 2021-12-16
				"q9jOzsYeV_w", -- 2022-05-11
				"aq6GPDhqPkQ", -- 2022-11-10
			},
			video_id = {
				"N8fodxhRilY", -- 2019-05-31
				"kgdEHUIG3Lo",
				"XLMxfxBsPYI",
				"EyWen57qH74",
				"CNJWtpK6y0s",
				"z3eHHfyLA54",
				"pk9fMeNFAck",
				"fvG_Q0Vtbsw",
				"hDvJSve9vOM",
				"3gymWm1zvZM",
				"fv13YWqvAec",
				"sWGeOnN62Mo",
				"j82J3cFkCts",
				"09plew6N6ic",
				"Ir-TYrdl0aU",
			},
		},
	},
	holobgm = {
		ch_id = "UCJFZiqLMntJufDCHc6bQixg",
		song = {
			lst_id = {
				"PL1NeGg1woXqnC8Rh_M0oO0QashTHocZqv",
				"PL1NeGg1woXqnPzWkH_Xqs3fxijJrgB-MF",
			},
		},
	},
}
Etc._cfg = {
  dir_data = Cfg.prj.dir .. "/www/song/data/etc",
}

function Etc.song_lst_id(name)

  local lst_id = {}
  local excld_video_id = {}

  ar.join(lst_id, Etc._cnst[name].song.lst_id)

  if Etc._cnst[name].song.lst_excld_video_id then
    ar.join(excld_video_id, Etc._cnst[name].song.lst_excld_video_id)
  end

  return lst_id, excld_video_id
end

function Etc.song_video(name)

  local video = {}
	
  if not Etc._cnst[name].song.video_id then return video end

  for idx, video_id in pairs(Etc._cnst[name].song.video_id) do

    video[video_id] = {}
  end

  return video
end

-- obj

function Etc.new()

  local obj = Utl.new(Etc)
  return obj
end

function Etc.init(_s)
end

--
-- video __
--

function Etc.video__init(_s)

  _s._video = {}
end

function Etc.video__(_s, video)

  _s._video = video
end

function Etc.video__by_jsn(_s, jsn)

  _s._video = cjson.decode(jsn)
end

function Etc.video__by_jsn_file(_s, path_jsn)

  local jsn = Utl.file_read(path_jsn)
  _s:video__by_jsn(jsn)
end

-- video view cnt

function Etc.video_view_cnt__(_s)

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

function Etc.video_view_cnt__0(_s) -- use not
	
	for video_id, _video in pairs(_s._video) do
		_video.view_cnt = 0
	end
end

function Etc.video_id__init(_s)

	_s._video_id = {}
end

function Etc.video_id__(_s)
	
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

function Etc.video_id__clr(_s)
	
		ar.clr(_s._video_id)
end

function Etc.video_id__srt(_s, prp)
	
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

function Etc.video_srtd__(_s)
	
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

function Etc.video__song(_s)

  _s:video__init()

  _s:video__add_song()

  _s:video_view_cnt__()
end

function Etc.video__add_song(_s)

  _s:video__add_song_lst()
  _s:video__add_song_video()
end

function Etc.video__add_song_lst(_s)

  local lst_id, excld_video_id = Etc.song_lst_id(_s._name)

  for idx, _lst_id in pairs(lst_id) do

    _s:video__add_by_lst_id(_lst_id, excld_video_id)
  end
end

function Etc.video__add_by_lst_id(_s, lst_id, excld_video_id)

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

function Etc.video__add_song_video(_s)

  ar.mrg(_s._video, Etc.song_video(_s._name))
end

function Etc.video__excld(_s, excld_video_id)

  for idx, _excld_video_id in pairs(excld_video_id) do

    _s._video[_excld_video_id] = nil
  end
end

--
-- srch
--

function Etc.ch_srch(_s, ch_id, word, video)

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

function Etc.video_2_jsn_prnt(_s)
	
	local jsn = _s:video_2_jsn()
	
  u.prnt(jsn)
end

function Etc.video_2_jsn_write(_s, path_file)
	
	local jsn = _s:video_2_jsn()
	
  Utl.file_write(path_file, jsn)
end

function Etc.video_2_jsn(_s)

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

function Etc.video__add(_s, video2)

  if not _s._video then _s:video__init() end

  for video_id2, tbl2 in pairs(video2) do

    _s._video[video_id2] = tbl2
  end
end

--
-- sub
--

function Etc.video__sub(_s, video2)

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

function Etc.video__ch_by_term(_s, ch_id, fr_date, to_date)

  fr_date = fr_date or Utl.date_y7()
  to_date = to_date or Utl.date_t7()

  _s:video__init()

  -- u.log(ch_id, fr_date, to_date)
  _s:video__add_by_ch(ch_id, fr_date, to_date)
end

function Etc.video__add_by_ch(_s, ch_id, fr_date, to_date, excld_video_id)

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

function Etc.main_song_video(_s, name)
	
	_s._name = name
  u.log(_s._name)
	
	_s:video__song_ttl_write()

	-- _s:video__song_ttl_ltst1_sub_ttl_ltst2_write()

	-- _s:song_video_data_rsync()
end

function Etc.video__song_ttl_write(_s)
	
	_s:video__song()

	local path_song_ttl = Etc._cfg.dir_data.."/".._s._name.."/"..Utl.datetime()..".json"
	_s:video_2_jsn_write(path_song_ttl)

	local path_t_ltst   = Etc._cfg.dir_data.."/".._s._name.."/ltst.t.json"
	Utl.cp(path_song_ttl, path_t_ltst)
end

function Etc.video__song_ttl_ltst1_sub_ttl_ltst2_write(_s)
	
	local path_jsn = _s:song_ttl_jsn_file_ltst()
	
	if #path_jsn < 2 then return end

	local video1 = Utl.tbl_by_jsn_file(path_jsn[1])
	local video2 = Utl.tbl_by_jsn_file(path_jsn[2])

	_s:video__(   video1)
	_s:video__sub(video2)

	local file_jsn1 = Utl.basename(path_jsn[1])
	local file_jsn2 = Utl.basename(path_jsn[2])

	local file_sub = Utl.ext_del(file_jsn1)..".-."..file_jsn2
	local path_sub = Etc._cfg.dir_data.."/".._s._name.."/"..file_sub

	_s:video_2_jsn_write(path_sub)

	-- Utl.cp(path_sub, Cfg.song_video.path_s_ltst)
end

function Etc.song_ttl_jsn_file_ltst(_s)
	
	local path_wc  = Etc._cfg.dir_data.."/".._s._name.."/????-??-??.??:??.json"
	local path_jsn = Utl.ls(path_wc, "-r")
	-- u.log_ar(path_jsn)
	
	return path_jsn
end

function Etc.data_rsync(_s)
	
	Utl.cmd("fish rsync.data.etc.fish")
end

