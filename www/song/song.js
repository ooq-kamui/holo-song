
var doc = document;

var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var plyr;

function onYouTubeIframeAPIReady(){
  plyr = new YT.Player('plyr', {
    height: '250',
    //height: '360',
    //width: '640',
    videoId: '68KV7JnrvDo',
    //videoId: 'o5lZMlrsdXM',
    playerVars: {
      autoplay: 0,
      controls: 1, 
      //mute:     1
      //playlist: "68KV7JnrvDo"
    },
    events: {
      'onReady':       plyr_ready,
      'onStateChange': plyr_st_ch
    }
  });
}

function plyr_ready(ev){
  log("ready");
}

function plyr__load(video_id){
  plyr.loadVideoById(video_id);
}

function plyr__load_ply(video_id){
  plyr__load(video_id);
  plyr_ply();
}

var g_plyr_load_time_pre = 0;
function plyr__load_lst(video_id){
  log("plyr__load_lst :" + video_id[0]);

  if (!plyr.loadPlaylist){return;}

  var now = Date.now();
  var timer = now - g_plyr_load_time_pre;

  if (timer < 3){
    dly(plyr.loadPlaylist, 2, video_id);
  }else{
    plyr.loadPlaylist(video_id);
  }

  g_plyr_load_time_pre = now;
}

function plyr__cue_lst(video_id){
  plyr.cuePlaylist(video_id);
}

function plyr_ply(){
  log("ply");
  plyr.playVideo();
}

function plyr_stp(){
  log("stp");
  plyr.stopVideo();
}

function plyr_st_ch(ev){
  var st = ev.data;
  log("st_ch : " + plyr_st(st));
}

function plyr_st(st){

  if (st == -1){return "UNSTARTED";}

  const _plyr_st = [
    "ENDED",
    "PLAYING",
    "PAUSED",
    "BUFFERING",
    "CUED"
  ];
  return (_plyr_st[st]) ? _plyr_st[st] : st;
}

// song

class Song {

  constructor(){

    this.g_video_srt;
    this.g_video_id_srt;

    this.g_video_flt;
    this.g_video_id_flt;

    this.g_srch_str_pre     = "";
    this.g_video_id_1st_pre = [];
  }

  // video

  video__(video){

    this.g_video_srt = this.video_srt(video);
  }

  // srt

  video_id_srt(video){

    this.g_video_id_srt = new Array()

    for (let [video_id, _video] of Object.entries(video)){

      if(_video.view_cnt){
        this.g_video_id_srt.push(video_id)
      }
    }

    var cmpr = function (video_id1, video_id2){

      return video[video_id2].view_cnt - video[video_id1].view_cnt;
    }
    this.g_video_id_srt.sort(cmpr);
    return this.g_video_id_srt;
  }

  video_srt(video){

    var _video_id_srt = this.video_id_srt(video);

    var video_srt = new Object();

    for (let [idx, video_id] of _video_id_srt.entries()){

      video_srt[video_id] = video[video_id];
    }
    return video_srt;
  }

  video_id_srt_slice(_video_id, lim){

    var idx      = this.g_video_id_flt.indexOf(_video_id);
    var video_id = this.g_video_id_flt.slice(idx, idx + lim);
    return video_id;
  }

  // flt

  video_elm__flt(str){

    var word = u.split_and_or(str);

    var _video_flt = this.video_flt(this.g_video_srt, word);
    this.ul_elm__upd(_video_flt);
    return _video_flt;
  }

  video_flt(video, word){

    this.g_video_flt    = new Object();
    this.g_video_id_flt = new Array();

    for (let [video_id, _video] of Object.entries(video)){

      if (is_match_and_or(_video.title, word)){
        this.g_video_flt[video_id] = _video;
        this.g_video_id_flt.push(video_id);
      }
    }
    return this.g_video_flt;
  }

  srch_bar__init(){

    var prm = url_prm();

    if (!(prm && prm.s)){return;}

    this.flt_bar_elm().value = prm.s;
  }

  srch_bar_str(){
    return this.flt_bar_elm().value;
  }

  srch_bar_focus(){

    this.flt_bar_elm().focus();
  }

  // elm

  ul_elm__upd(video){

    this.ul_elm__cre(video);
  }

  ul_elm__cre(video){

    var ul_elm = doc.getElementById('video_lst');

    ul_elm.textContent = null;

    var url_base = "https://www.youtube.com/watch?v=";
    var view_cnt_elm , title_spn_elm , title_elm , url

    for (let [video_id, _video] of Object.entries(video)){

      view_cnt_elm = this.cre_elm_span(_video.view_cnt, "view_cnt");

      title_spn_elm = this.cre_elm_span(_video.title   , "title"   );

      title_elm = doc.createElement('a');
      title_elm.appendChild(title_spn_elm);
      //url = url_base + video_id;
      url = "javascript:song.onclick('" + video_id + "');";
      title_elm.setAttribute("href", url);
      //title_elm.setAttribute("target", "_blank");
      //title_elm.setAttribute("onclick", "onclick('" + video_id + "')");
      //title_elm.setAttribute("onclick", "onclick();");

      var li_elm = doc.createElement('li');
      li_elm.appendChild(view_cnt_elm);
      li_elm.appendChild(title_elm);

      ul_elm.appendChild(li_elm);
    }
  }

  cre_elm_span(str, cls){

    var elm = doc.createElement('span');
    elm.appendChild(doc.createTextNode(str));
    elm.classList.add(cls);
    return elm;
  }

  flt_bar_elm(){

    return doc.getElementById('flt_bar');
  }

  // lst

  onclick(video_id){

    var lim = 5;
    var video_id_lim = this.video_id_srt_slice(video_id, lim)

    plyr__load_lst(video_id_lim);
    //plyr__load(video_id);
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
      song.video_elm__flt(song.srch_bar_str())
    }
  }

  __init(){

    this.video__init_req();
    this.srch_bar__init();
    this.srch_bar_focus();
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

  var qery_str = window.location.search;

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
//         this.srch_bar_focus();
//       }
//       break;
//   }
// };

// main

var song = new Song();
song.__init();

function flt_bar_elm_keyup(){

  var keyupStack = [];
  keyupStack.push(1);
  dly(function (){

    keyupStack.pop();

    if (keyupStack.length !== 0){return;}

    // --

    var srch_str = this.value;
    srch_str = srch_str.trim();

    if (srch_str == song.g_srch_str_pre){return;}

    log("__flt :" + srch_str + ":" + song.g_srch_str_pre + ":");

    var video = song.video_elm__flt(srch_str);
    song.g_srch_str_pre = srch_str;

    if (!srch_str || srch_str == ""){return;}

    var lim = 5; // 20;
    //var video_id_1st = Object.keys(video).slice(0, lim);
    //var video_id_1st = song.g_video_id_srt.slice(0, lim);
    var video_id_1st = song.g_video_id_flt.slice(0, lim);

    if (!video_id_1st[0]){return;}
    if (video_id_1st[0] == song.g_video_id_1st_pre[0]){return;}

    log("__load_lst :" + video_id_1st[0] + ":" + song.g_video_id_1st_pre[0] + ":");
    log(video_id_1st);

    plyr__load_lst(video_id_1st);
    song.g_video_id_1st_pre = video_id_1st;

    //dly(plyr_ply, 5000);

    //var video_id_flw = Object.keys(video).slice(1, lim);
    //log(video_id_flw);
    //plyr__cue_lst( video_id_flw);
    //dly(plyr__cue_lst, 10, video_id_flw);

  }.bind(this), 500);
}
song.flt_bar_elm().addEventListener('keyup', flt_bar_elm_keyup);

