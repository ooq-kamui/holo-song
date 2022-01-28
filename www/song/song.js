
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

    if (timer < 3){
      dly(this._ytplyr.loadPlaylist, 2, video_id);

    }else{
      this._ytplyr.loadPlaylist(video_id);
    }

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

  static ready(ev){
    log("ready");
  }

  static st_ch(ev){

    var st = ev.data;
    log("st_ch: " + Plyr.st(st));
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

    this._video_srt;
    this._video_id_srt;

    this._video_flt;
    this._video_id_flt;

    this._srch_str_pre     = "";
    this._video_id_1st_pre = [];

    this.video__init_req();
    this.flt_bar__init();
    this.flt_bar_focus();

    var song = this;
    function flt_bar_keyup(ev){

      log("isComposing: " + ev.isComposing);
      if (ev.isComposing || ev.keyCode === 229){return;}

      var keyup_stack = [];
      keyup_stack.push(1);
      dly(function (){

        keyup_stack.pop();

        if (keyup_stack.length !== 0){return;}

        song.flt_ply(this.value);

      }.bind(this), 500);
    }
    this.flt_bar_elm().addEventListener('keyup', flt_bar_keyup);
  }

  // video

  video__(_video){

    this._video = _video

    this.video_srt__();
  }

  // srt

  video_id_srt__(video){

    if (!video){video = this._video}

    this._video_id_srt = new Array()

    for (let [video_id, _video] of Object.entries(video)){

      if(_video.view_cnt){
        this._video_id_srt.push(video_id)
      }
    }

    var cmpr = function (video_id1, video_id2){

      return video[video_id2].view_cnt - video[video_id1].view_cnt;
    }
    this._video_id_srt.sort(cmpr);
    return this._video_id_srt;
  }

  video_srt__(_video){

    if (!_video){_video = this._video}

    var _video_id_srt = this.video_id_srt__(_video);

    this._video_srt = new Object();

    for (let [idx, _video_id] of _video_id_srt.entries()){

      this._video_srt[_video_id] = _video[_video_id];
    }
  }

  video_id_flt_slice(_video_id, lim){
    log("video_id_flt_slice");
    log(_video_id);

    var idx      = this._video_id_flt.indexOf(_video_id);
    var video_id = this._video_id_flt.slice(idx, idx + lim);
    log(video_id);
    return video_id;
  }

  // flt

  video_flt__(str){

    if (!str){str = this.srch_bar_str();}

    var word = u.split_and_or(str);

    this.video_flt__by_word(word);

    //this.elm_ul__upd();
    this.elm_ul__flt();
  }

  video_flt__by_word(word, video){

    if(!video){video = this._video_srt;}

    this._video_flt    = new Object();
    this._video_id_flt = new Array();

    for (let [video_id, _video] of Object.entries(video)){

      if (is_match_and_or(_video.title, word)){
        this._video_flt[video_id] = _video;
        this._video_id_flt.push(video_id);
      }
    }
    return this._video_flt;
  }

  flt_bar__init(){

    var prm = url_prm();

    if (!(prm && prm.s)){return;}

    this.flt_bar_elm().value = prm.s;
  }

  srch_bar_str(){

    return this.flt_bar_elm().value;
  }

  flt_bar_focus(){

    this.flt_bar_elm().focus();
  }

  // elm

  elm_ul__flt(video_flt){

    if (!video_flt){video_flt = this._video_flt;}

    var elm_ul = this.video_lst_elm_ul();
    var elm_li = elm_ul.children;

    for (let idx = 0; idx < elm_li.length; idx++){
      if(video_flt[elm_li[idx].id]){
        elm_li[idx].style.display ="block";
      }else{
        elm_li[idx].style.display ="none";
      }
    }
  }

  elm_ul__upd(_video){

    if (!_video){_video = this._video_flt;}

    this.elm_ul__cre(_video);
  }

  video_lst_elm_ul(){

    return doc.getElementById('video_lst');
  }

  elm_ul__cre(video){

    if (!video){video = this._video_srt;}

    var elm_ul = this.video_lst_elm_ul();

    elm_ul.textContent = null;

    var view_cnt_elm , title_elm_spn , title_elm , url;

    for (let [video_id, _video] of Object.entries(video)){

      view_cnt_elm  = this.elm_span__cre(_video.view_cnt, "view_cnt");

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

    return doc.getElementById('flt_bar');
  }

  // lst

  onclick(_video_id){

    this.plyr__ply_by_video_id(_video_id);
  }

  plyr__ply_by_video_id(_video_id){

    //this.ply_video_elm_color__(false);
    this.ply_video_elm__(false);

    this.ply_video_id__by_video_id(_video_id);

    this._plyr.__load_lst(this._ply_video_id);

    this.ply_video_elm__(true);
  }

  ply_video_elm__(val){

    if (!this._ply_video_id){return;}

    var elm;
    for (let [idx, _video_id] of this._ply_video_id.entries()){

      elm = doc.getElementById(_video_id).children[1];
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
    log("ply_video_id");
    log(this._ply_video_id);
  }

  // video req

  video__init_req(){

    var song = this;

    const xhr = new XMLHttpRequest();
    xhr.open("GET", u.data_url());
    xhr.send();
    xhr.onreadystatechange = function(){

      if (!(xhr.readyState == 4 && xhr.status == 200)){return;}

      var video = JSON.parse(xhr.responseText);      
      song.video__(video);

      song.elm_ul__cre();

      song.video_flt__()
    }
  }

  flt_ply(srch_str){

    srch_str = srch_str.trim();

    if (srch_str == this._srch_str_pre){return;}

    log("__flt :" + srch_str + ":" + this._srch_str_pre + ":");

    this.video_flt__(srch_str);
    this._srch_str_pre = srch_str;

    if (!srch_str || srch_str == ""){return;}

    var video_id_flt_1 = this._video_id_flt[0];

    if (!video_id_flt_1){return;}

    log(video_id_flt_1);

    if (video_id_flt_1 == this._video_id_flt_1_pre){return;}

    log("video_id_flt_1 :" + video_id_flt_1 + ":" + this._video_id_flt_1_pre);

    var s_idx = rnd(0, this._video_id_flt.length);

    log("s_idx: " + s_idx);

    this.plyr__ply_by_video_id(this._video_id_flt[s_idx]);

    this._video_id_flt_1_pre = video_id_flt_1;
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

function log(str){
  console.log(str);
}

function dly(fnc, msec, arg){

  setTimeout(fnc, msec, arg);
}

// doc.onkeydown = function(e) {
//   switch (e.keyCode) {
//     case 191: // Key: /
//       if (doc.activeElement.id != 'flt_bar'){
//         this.flt_bar_focus();
//       }
//       break;
//   }
// };

// main

// alias
var doc = document;
var win = window;

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
        'onStateChange': Plyr.st_ch
      }
    }
  );
  song._plyr._ytplyr = ytplyr;
}

