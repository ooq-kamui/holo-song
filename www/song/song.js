
// plyr

class Plyr {

  yt_url_base = "https://www.youtube.com/watch?v=";

  constructor(){

    this._ytplyr; // = ytplyr;

    this._load_time_pre = 0;
  }

  __load(video_id){

    this._ytplyr.loadVideoById(video_id);
  }

  __load_lst(video_id){
    log("__load_lst :" + video_id);

    if (!this._ytplyr.loadPlaylist){return;}

    var now = Date.now();
    var timer = now - this._load_time_pre;

    /*
    if (timer < 3){
      log("__load_lst : timer < 3");
      dly(this._ytplyr.loadPlaylist, 2, video_id);

    }else{
      log("__load_lst : else ( timer > 3 )");
      this._ytplyr.loadPlaylist(video_id);
    }
     */
    this._ytplyr.loadPlaylist(video_id);

    this._load_time_pre = now;
  }

  cue_lst(video_id){

    this._ytplyr.cuePlaylist(video_id);
  }

  ply(){
    log("ply");

    this._ytplyr.playVideo();
  }

  stp(){
    log("stp");

    this._ytplyr.stopVideo();
  }

  st_ch(ev){

    var st = ev.data;
    log("st_ch: " + Plyr.st(st));

    if (Plyr.st(st) == "ENDED"){
      log("ENDED");
      this.ply_rnd();
    }
  }

  static ready(ev){
    log("ready");
  }

  static _st = [
    "ENDED",
    "PLAYING",
    "PAUSED",
    "BUFFERING",
    "CUED"
  ];

  static st(st){

    if (st == -1){return "UNSTARTED";}

    return (Plyr._st[st]) ? Plyr._st[st] : st;
  }
}

// song

class Song {

  constructor(){

    this._plyr = new Plyr();

    this._video;
    this._video_id;

    this._video_flt;
    this._video_id_flt;

    this._srch_str_pre     = "";
    this._video_id_1st_pre = [];

    this.video__init_req();
    this.flt_bar__init();
    this.flt_bar__focus();

    var keyup_stack = [];
    var slf = this;
    function flt_bar_keyup_exe(force){

      keyup_stack.pop();

      if (keyup_stack.length !== 0){return;}

      var str = slf.flt_bar_elm().value;
      slf.flt_ply(str, force);
    }
    function flt_bar_keyup(ev){

      log("isComposing: " + ev.isComposing);
      log("keyCode: "     + ev.keyCode    );
      if (ev.isComposing || ev.keyCode === 229){return;}
      if (ev.keyCode === 16){return;} // shift
      if (ev.keyCode ===  0){return;} // del ?
      log("flt_bar_keyup_exe");

      var force = (ev.code == "Enter") ? true : false;

      keyup_stack.push(1);

      dly(flt_bar_keyup_exe, 700, force);
    }
    this.flt_bar_elm().addEventListener('keyup', flt_bar_keyup);
  }

  // video

  video__(_video){

    this._video = _video;

    this._video_id = this.new_video_id();
  }

  new_video_id(){

    let video_id = new Array();

    for (let [_video_id, _video] of Object.entries(this._video)){

      if(!_video.view_cnt || _video.view_cnt == 0 || !_video.cdt){continue;}

      video_id.push(_video_id);
    }
    return video_id;
  }

  // 
  // srt
  // 

  // video ordr

  static _video_ordr_df = [
    "view_cnt",
    "cdt"
  ];

  video_ordr__(ordr){

    if (!Song._video_ordr_df.includes(ordr)){

      ordr = Song._video_ordr_df[0];
    }

    this._video_ordr = ordr;
  }

  video_ordr__tgl(){

    let idx = Song._video_ordr_df.indexOf(this._video_ordr);

    idx = idx + 1;
    if (idx >= Song._video_ordr_df.length) idx = 0;

    // this._video_ordr = Song._video_ordr_df[idx];
    this.video_ordr__(Song._video_ordr_df[idx]);
  }

  // video_id srtd

  video_id_srtd(){

    return this._video_id_flt;
  }

  video_id_srtd_view_cnt__(){

    let slf = this;
    let cmpr_view_cnt = function(video_id1, video_id2){

      let ret = slf._video[video_id2].view_cnt - slf._video[video_id1].view_cnt;
      return ret;
    }
    this._video_id_flt.sort(cmpr_view_cnt);
  }

  video_id_strd_cdt__(){

    let slf = this;
    let cmpr_cdt = function(video_id1, video_id2){

      let ret;
      if (slf._video[video_id2].cdt > slf._video[video_id1].cdt){
        ret =  1;
      }else{
        ret = -1;
      }
      return ret;
    }
    this._video_id_flt.sort(cmpr_cdt);
  }

  // video __ srt

  video__srt(ordr){
    log("video__srt");

    if (ordr){this.video_ordr__(ordr);}

    if       (this._video_ordr == "view_cnt"){
      this.video_id_srtd_view_cnt__();

    }else if (this._video_ordr == "cdt"     ){
      this.video_id_strd_cdt__();
    }

    this.elm_ul__srt();
  }

  video__srt_tgl(){

    this.video_ordr__tgl();

    this.video__srt();

    this.ordr_swtch_elm__();
  }

  // 
  // flt
  // 

  static _excld_video_id = [
    "lxJ7SXMEPto" // azki
  ];

  video_id_flt_slice(_video_id, lim){

    var idx      = this._video_id_flt.indexOf(_video_id);
    var video_id = this._video_id_flt.slice(idx, idx + lim);

    var del_idx;
    for (let [_excld_idx, excld_video_id] of Song._excld_video_id.entries()){

      del_idx = video_id.indexOf(excld_video_id);
      if (del_idx != -1){
        log("plyr excld : " + excld_video_id);
        video_id.splice(del_idx, 1);
      }
    }

    //log(video_id);
    return video_id;
  }

  video_flt__(str){

    if (!str){str = this.srch_bar_str();}

    var word = u.split_and_or(str);

    this.video_flt__by_word(word);

    this.elm_ul__flt();

    if (!str || str == ""){
      scrl(0, 0);
    }
  }

  video_flt__by_word(word){

    this._video_flt    = new Object();
    this._video_id_flt = new Array();

    let _video;
    for (let [idx, _video_id] of this._video_id.entries()){

      _video = this._video[_video_id];

      if (!_video.title){continue;}

      if (!is_match_and_or(_video.title, word)){continue;}

      this._video_flt[_video_id] = _video;
      this._video_id_flt.push(_video_id);
    }
  }

  flt_bar__init(){

    var prm = url_prm();

    if (!(prm && prm.s)){return;}

    this.flt_bar_elm().value = prm.s;
  }

  srch_bar_str(){

    return this.flt_bar_elm().value;
  }

  flt_bar__focus(){

    this.flt_bar_elm().focus();
  }

  // 
  // elm
  // 

  elm_ul__flt(){

    let elm_ul = this.video_lst_elm_ul();
    let elm_li = elm_ul.children;
    for (let idx = 0; idx < elm_li.length; idx++){

      if(ar_in(this._video_id_flt, elm_li[idx].id)){
        elm_li[idx].style.display = "block";
      }else{
        elm_li[idx].style.display = "none";
      }
    }
  }

  elm_ul__srt(){

    let video_id_srtd = this.video_id_srtd();

    let elm_li;
    for (let idx = 0; idx < video_id_srtd.length; idx++){

      elm_li = elm_by_id(video_id_srtd[idx]);

      if (!elm_li){
        log("null : " + video_id_srtd[idx]);
        continue;
      }

      elm_li.style.order = idx;
    }
  }

  video_lst_elm_ul(){

    return elm_by_id('video_lst');
  }

  elm_ul__cre(){

    let video = this._video;

    let elm_ul = this.video_lst_elm_ul();

    elm_ul.textContent = null;

    let view_cnt_elm , title_elm_spn , title_elm , url;

    for (let [video_id, _video] of Object.entries(video)){

      if (!_video.view_cnt || !_video.title){continue;}

      if (_video.new){
        view_cnt_elm  = this.elm_span__cre(_video.view_cnt, "view_cnt_new");
      }else{
        view_cnt_elm  = this.elm_span__cre(_video.view_cnt, "view_cnt");
      }

      title_elm_spn = this.elm_span__cre(_video.title, "title");

      title_elm = doc.createElement('a');
      title_elm.appendChild(title_elm_spn);
      //url = Song.yt_url_base + video_id;
      url = "javascript:song.onclick('" + video_id + "');";
      title_elm.setAttribute("href", url);
      //title_elm.setAttribute("onclick", "onclick();");

      var elm_li = doc.createElement('li');
      elm_li.appendChild(view_cnt_elm);
      elm_li.appendChild(title_elm);
      elm_li.setAttribute("id", video_id);

      elm_ul.appendChild(elm_li);
    }
  }

  elm_span__cre(str, cls){

    var elm = doc.createElement('span');
    elm.appendChild(doc.createTextNode(str));
    elm.classList.add(cls);
    return elm;
  }

  flt_bar_elm(){

    return elm_by_id('flt_bar');
  }

  ordr_swtch_elm__(){

    elm_by_id('ordr_swtch').textContent = this.ordr_swtch_elm_txt();
  }

  ordr_swtch_elm_txt(){

    let txt;
    if      (this._video_ordr == "view_cnt"){txt = this.swtch_elm_txt("l");}
    else if (this._video_ordr == "cdt"     ){txt = this.swtch_elm_txt("r");}
    return txt;
  }

  swtch_elm_txt(lr){

    let txt;
    if      (lr == "l"){txt = "🟢-";}
    else if (lr == "r"){txt = "-🟢";}
    return txt;
  }

  // 
  // lst
  // 

  onclick(_video_id){

    this.plyr__ply_by_video_id(_video_id);
  }

  plyr__ply_by_video_id(_video_id){

    this.ply_video_elm__(false);

    this.ply_video_id__by_video_id(_video_id);

    this._plyr.__load_lst(this._ply_video_id);

    this.ply_video_elm__(true);
  }

  ply_video_elm__(val){

    if (!this._ply_video_id){return;}

    var elm;
    for (let [idx, _video_id] of this._ply_video_id.entries()){

      elm = elm_by_id(_video_id).children[1];
      if (val){
        elm.classList.add(   "playing");
      }else{
        elm.classList.remove("playing");
      }
    }
  }

  ply_video_id__by_video_id(_video_id, lim){

    if (!lim){lim = 5;}

    this._ply_video_id = this.video_id_flt_slice(_video_id, lim)

    log(this._ply_video_id);
  }

  // video req

  video__init_req(){

    var song = this;

    const xhr = new XMLHttpRequest();
    xhr.open("GET", u.data_url());
    xhr.setRequestHeader('If-Modified-Since', 'Thu, 01 Jun 1970 00:00:00 GMT');
    xhr.send();
    xhr.onreadystatechange = function(){

      if (!(xhr.readyState == 4 && xhr.status == 200)){return;}

      var video = JSON.parse(xhr.responseText);      
      song.video__(video);

      song.elm_ul__cre();

      song.video_flt__()

      song.video__srt("view_cnt");
    }
  }

  flt_ply(srch_str, force){

    srch_str = srch_str.trim();

    if ((srch_str == this._srch_str_pre) && !force){return;}

    log("__flt :" + srch_str + ":" + this._srch_str_pre + ":");

    this.video_flt__(srch_str);

    this.video__srt();

    this._srch_str_pre = srch_str;

    if ((!srch_str || srch_str == "") && !force){return;}

    this.ply_rnd();
  }

  ply_rnd(){

    if (this._video_id_flt.length == 0){return;}

    var video_id = ar_rnd(this._video_id_flt);

    this.plyr__ply_by_video_id(video_id);

    this.video_lst__scrl();
  }

  video_lst__scrl(video_id){
    log("video_lst__scrl");

    video_id = video_id ? video_id : this._ply_video_id[0];
    if (!video_id){return;}

    log("video_id: " + video_id);

    var video_elm = elm_by_id(video_id);
    var video_top = video_elm.offsetTop;
    // log("top: " + video_top);

    var header_elm = elm_by_id('header');
    var header_h = header_elm.clientHeight;
    // log("h: " + header_h);

    var scrl_y = video_top - header_h - 28;

    // var lst_elm = elm_by_id('video_lst_scrl');
    // lst_elm.scroll(0, scrl_y);
    scrl(0, scrl_y);
  }
}

//
// util
//

class u {

  static data_url(){

    var prm = url_prm();
    var file_json = (prm && prm.f) ? prm.f : 's.ltst.json';

    var data_domain  = 'ooq.jp';
    var data_dir     = 'pri/holo/song/data';
    var data_url_dir = data_domain + "/" + data_dir;
    var data_url = 'https://' + data_url_dir + "/" + file_json;

    return data_url;
  }

  static split_and_or(str){

    var word = str.trim().split(/\s/g);

    for (let [idx, word_and] of word.entries()){
    
      word[idx] = u.split_or(word_and);
    }
    return word;
  }

  static split_or(word_and){

    var split_char = ",";

    if (!is_match(word_and, split_char)){return word_and;}

    var exp = new RegExp("^" + split_char + "+|" + split_char + "+$", "g");

    var word = word_and.replace(exp,'').split(split_char);
    return word;
  }
}

function url_prm(){

  var qery_str = win.location.search;

  if(!qery_str){return;}

  qery_str = qery_str.substring(1);

  var prms = qery_str.split('&');

  var prm = new Object();
  var elm, key, val;
  for (var i = 0; i < prms.length; i++){

    elm = prms[i].split('=');
    key = decodeURIComponent(elm[0]);
    val = decodeURIComponent(elm[1]);
    prm[key] = val;
  }
  return prm;
}

function is_match(str, word){

  var ret = false;

  str  = str.toLowerCase();
  word = word.toLowerCase();

  if (str.indexOf(word) >= 0){
    ret = true;
  }
  return ret;
}

function is_match_and_or(str, word){

  var ret = false;

  for (let [idx, word_and] of word.entries()){

    if      (typeof word_and == "string"){

      ret = is_match(   str, word_and);

    }else if(typeof word_and == "object"){

      ret = is_match_or(str, word_and);
    }
    if (!ret){break;}
  }
  return ret;
}

function is_match_or(str, word){

  var ret = false;

  for (let [idx, word_or] of word.entries()){
    ret = is_match(str, word_or);
    if (ret){break;}
  }
  return ret;
}

function rnd(min, max){

  var val = Math.floor(Math.random() * (max - min + 1) + min);
  return val
}

function ar_rnd(ar){

  var idx = ar_rnd_idx(ar);
  var val = ar[idx];
  return val;
}

function ar_rnd_idx(ar){

  var idx = rnd(0, ar.length - 1);
  return idx;
}

function ar_in(ar, val){

  let idx = ar.indexOf(val);
  let ret = idx >= 0 ? true : false ;
  return ret;
}

// alias

var doc = document;
var win = window;

function log(str){
  console.log(str);
}

function dly(fnc, msec, arg){
  setTimeout(fnc, msec, arg);
}

function scrl(x, y){
  scrollTo(x, y);
}

function elm_by_id(id){
  return doc.getElementById(id);
}

// main

var tag = doc.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var js1 = doc.getElementsByTagName('script')[0];
js1.parentNode.insertBefore(tag, js1);

var song = new Song();

// ytplyr

var ytplyr;
win.onYouTubeIframeAPIReady = function(){

  ytplyr = new YT.Player (
    'plyr',
    {
      height: '250', // '360',
      //width: '640',
      videoId: '68KV7JnrvDo',
      playerVars: {
        autoplay: 0,
        controls: 1, 
        disablekb: 0,
        //mute:     1
        //playlist: "68KV7JnrvDo"
      },
      events: {
        'onReady':       Plyr.ready,
        'onStateChange': song._plyr.st_ch.bind(song)
      }
    }
  );
  song._plyr._ytplyr = ytplyr;
}

doc.onkeydown = function (e){
  switch (e.keyCode){
    case 191: // key: /
      if (doc.activeElement.id != 'flt_bar'){
        e.preventDefault();
        song.flt_bar__focus();
      }
      break;
  }
};

