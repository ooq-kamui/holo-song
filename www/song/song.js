
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
    log("__load_lst    :" + video_id);

    if (!this._ytplyr.loadPlaylist){return;}

    this._ytplyr.loadPlaylist(video_id);

    this._load_time_pre = Date.now();
    
    let dly_time = 1800;
    this._dly_id = dly2(dly_time, this.__load_lst_re.bind(this), video_id);
  }
  
  __load_lst_re(video_id){
    log("__load_lst re :" + video_id);
    
    this._ytplyr.loadPlaylist(video_id);
    
    this._dly_id = null;
  }
  
  if_dly__cncl(){
    
    if (! this._dly_id){return;}
    
    this.dly__cncl();
  }
  
  dly__cncl(){
    
    if (! this._dly_id){return;}
    
    log("dly__cncl");
    
    dly__cncl(this._dly_id);
    
    this._dly_id = null;
  }

  cue_lst(video_id){

    this._ytplyr.cuePlaylist(video_id);
  }

  ply(){
    log("ply");

    this._ytplyr.playVideo();
  }

  stp(){
    log('stp');

    this._ytplyr.stopVideo();
  }

  size__(w, h){
    
    this._ytplyr.setSize(w, h);
  }
  
  // 
  // static
  // 

  static ready(ev){
    log('plyr ready');
  }

  static _st = [
    'ENDED',
    'PLAYING',
    'PAUSED',
    'BUFFERING',
    'none',
    'CUED'
  ];

  static st(st){

    if (st == -1){return 'UNSTARTED';}

    return (Plyr._st[st]) ? Plyr._st[st] : st;
  }
}

// song

class Song {

  constructor(menu){

    this._plyr       = new Plyr();
    this._plyr_ready = false;

    this._video;
    this._video_id;

    this._video_flt;
    this._video_id_flt;

    this._flt_str_pre      = "";
    this._video_id_1st_pre = [];
    
    this._video_file;

    this.video_ordr__init();

    this.video__init();
    
    this.flt_bar__init();
    this.flt_bar__focus();
    
    let keyup_stack = [];
    let slf = this;

    let flt_bar_keyup_exe = function (force){

      keyup_stack.pop();

      if (keyup_stack.length !== 0){return;}

      slf.flt_ply(force);
    }

    let flt_bar_keyup = function (ev){
      // log("flt_bar_keyup");
      // log("isComposing: " + ev.isComposing);
      // log("keyCode: "     + ev.keyCode    );
      
      if (ev.isComposing || ev.keyCode === 229){return;}
      if (ev.keyCode === 16){return;} // shift
      if (ev.keyCode ===  0){return;} // del ?
      if (ev.keyCode === 27){return;} // esc

      keyup_stack.push(1);
      
      let force = (ev.code == "Enter") ? true : false;
      dly(flt_bar_keyup_exe, 700, force);
    }
    this.flt_bar_elm().addEventListener('keyup' , flt_bar_keyup);
    
    let flt_bar_cncl = function (ev){
      log("flt_bar_cncl");

      keyup_stack.push(1);
      
      let force = false;
      flt_bar_keyup_exe(force);
      // dly(flt_bar_keyup_exe, 700, force);
    }
    this.flt_bar_elm().addEventListener('search', flt_bar_cncl);
    
    // plyr size
    
    this.plyr_size__init();
    
    this._menu = menu;
  }

  // video

  video__(_video){
    // log(_video);

    this._video = _video;

    this._video_id = this.new_video_id();
  }

  new_video_id(){
    // log("new_video_id")

    let video_id = new Array();

    for (let [_video_id, _video] of Obj.entries(this._video)){

      // log(_video_id)
      // log(_video)
      
      if(_video.view_cnt == undefined || _video.cdt == undefined){
        // log("continue")
        continue;
      }

      video_id.push(_video_id);
    }
    // log("new_video_id end")
    return video_id;
  }

  // 
  // srt
  // 

  // video ordr

  static _video_ordr_def = [
    "view_cnt",
    "cdt"
  ];

  static _video_ordr_op_def = [
    "asc",
    "dsc"
  ];

  video_ordr__init(){
    
    this.video_ordr__by_url_prm();
  }

  video_ordr__by_url_prm(){

    let prm = this.url_prm();

    let ordr = prm.o || 'view_cnt';
    this.video_ordr__(ordr);

    let ordr_op = prm.o_op || 'dsc';
    this.video_ordr_op__(ordr_op);
  }

  video_ordr(){
    
    return this._video_ordr;
  }
    
  video_ordr__(ordr){

    if (!Song._video_ordr_def.includes(ordr)){

      ordr = Song._video_ordr_def[0];
    }

    this._video_ordr = ordr;

    this.ordr_swtch_elm__();
  }

  video_ordr__tgl(){

    let idx = Song._video_ordr_def.indexOf(this._video_ordr);

    idx = idx + 1;
    if (idx >= Song._video_ordr_def.length) idx = 0;

    this.video_ordr__(Song._video_ordr_def[idx]);
  }

  video_ordr_op__tgl(){

    let idx = Song._video_ordr_op_def.indexOf(this._video_ordr_op);

    idx = idx + 1;
    if (idx >= Song._video_ordr_op_def.length) idx = 0;

    this.video_ordr_op__(Song._video_ordr_op_def[idx]);
  }

  video_ordr_op(){
    
    return this._video_ordr_op;
  }
    
  video_ordr_op__(ordr_op){

    if (!Song._video_ordr_op_def.includes(ordr_op)){

      ordr_op = Song._video_ordr_op_def[0];
    }

    this._video_ordr_op = ordr_op;

    this.ordr_op_swtch_elm__();
  }

  // video_id srtd

  video_id_srtd(){

    return this._video_id_flt;
  }

  video_id_srtd_view_cnt__(){

    let slf = this;
    let cmpr_view_cnt = function(video_id1, video_id2){

      let ret = slf._video[video_id2].view_cnt - slf._video[video_id1].view_cnt;

      if (slf._video_ordr_op == "asc"){ret = - ret}

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

      if (slf._video_ordr_op == "asc"){ret = - ret}

      return ret;
    }
    this._video_id_flt.sort(cmpr_cdt);
  }

  // video __ srt

  video__srt(ordr){
    log('video__srt');

    if (ordr){this.video_ordr__(ordr);}

    if       (this._video_ordr == 'view_cnt'){
      this.video_id_srtd_view_cnt__();

    }else if (this._video_ordr == 'cdt'     ){
      this.video_id_strd_cdt__();
    }

    this.elm_ul__srt();
  }

  video__srt_tgl(){

    this.video_ordr__tgl();
    this.video__srt();
  }

  video__srt_op_tgl(){

    this.video_ordr_op__tgl();
    this.video__srt();
  }

  // 
  // flt
  // 

  static _excld_video_id = [
    "lxJ7SXMEPto", // azki
    "7o_YL35T93w", // azki
    "O4Oz8Gn6oDY", // azki
    "YcfZziSg0cg", // kanata & azki
    "FefGzx_-Onk"  // dazbee
  ];

  video_id_flt_slice(_video_id, lim){

    let idx      = this._video_id_flt.indexOf(_video_id);
    let video_id = this._video_id_flt.slice(idx, idx + lim);

    let del_idx;
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

    if (!str){str = this.flt_bar_str();}
    
    let tmp = str.split(/\s*-\s*/);
    tmp[0] = tmp[0].trim();
    // log(tmp);
    
    let word_match;
    if (tmp[0] == ''){
      word_match = null;
    }else{
      word_match = Flt_word.split(tmp[0]);
    }
    
    let word_excld = null;
    if (tmp[1]){
      word_excld = Flt_word.split(tmp[1]);
    }

    this.video_flt__by_word(word_match, word_excld);
    
    this.elm_ul__flt();
    
    this._flt_str_pre = str;

    if (str == ''){
      this.video_lst__scrl_top();
      // scrl(0, 0);
    }
  }

  video_flt__by_word(word, excld){
    log('video_flt__by_word');
    
    if ((!word) && (!excld)){
      log('flt not');
      
      this._video_flt    = this._video;
      this._video_id_flt = this._video_id;
      return;
    }

    this._video_flt    = new Obj();
    this._video_id_flt = new Array();

    let _video;
    for (let [idx, _video_id] of this._video_id.entries()){

      _video = this._video[_video_id];

      if (! _video.title){continue;}

      if (excld){
        if (  Flt_word.is_match(_video.title, excld)){continue;}
      }
      
      if (word){
        if (! Flt_word.is_match(_video.title, word )){continue;}
      }

      this._video_flt[_video_id] = _video;
      this._video_id_flt.push(_video_id);
    }
  }

  flt_bar__init(){

    let prm = this.url_prm();
    
    if (!prm.s){return;}

    this.flt_bar_str__(prm.s);
  }

  flt_bar_str__(str){

    this.flt_bar_elm().value = str;
  }
  
  flt_bar_str(){

    return this.flt_bar_elm().value;
  }

  flt_bar__focus(){

    this.flt_bar_elm().focus();
  }

  s__(flt_str){ // call fr html
    
    this.flt_bar_str__(flt_str);
    
    this.flt_ply(false);
  }
  
  f__(video_file, flt_str){
  
    if (! flt_str){flt_str = '';}
    
    this.video_file__(video_file);
    
    this.flt_bar_str__(flt_str);
    
    this.video__req();
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
  
  elm_ul__sndtmr(){

    let elm_ul = this.video_lst_elm_ul();
    elm_ul.textContent = null;

    let elm_sndtmr_clone = this.elm_li_sndtmr__clone();
    elm_ul.__add(elm_sndtmr_clone);
  }
  
  elm_li_sndtmr__clone(){
    
    let r_node = elm__clone('#video_li_sndtmr_tmpl');
    return r_node;
  }

  elm_ul__cre(){

    let video = this._video;

    let elm_ul = this.video_lst_elm_ul();

    elm_ul.textContent = null;

    let view_cnt_elm , title_elm_spn , title_elm , url;

    for (let [video_id, _video] of Obj.entries(video)){

      if (_video.view_cnt == undefined || !_video.title){continue;}

      let elm_clone = this.elm_li__clone(video_id, _video);
      elm_ul.__add(elm_clone);
      // elm_ul.appendChild(elm_clone);
    }
  }

  elm_li__clone(video_id, _video){

    let r_node = elm__clone('#video_li_tmpl');
    
    r_node.elm('li').attr__('id', video_id);

    let t_elm = r_node.elm('.view_cnt');
    t_elm.textContent = _video.view_cnt;
    if (_video.new){
      t_elm.classList.replace('view_cnt', 'view_cnt_new');
    }
    
    r_node.elm('.title').textContent = _video.title;

    let href_js = "javascript:song.p('" + video_id + "');";
    r_node.elm('a').attr__('href', href_js);
    
    let src = 'https://i.ytimg.com/vi/' + video_id + '/mqdefault.jpg';
    r_node.elm('.thmb').attr__('src', src);
    
    let cdt = _video.cdt.substring(0, 10);
    if (_video.new){
      cdt = 'new ' + cdt;
    }
    r_node.elm('.cdt').textContent = cdt;

    return r_node;
  }

  flt_bar_elm(){

    return elm_by_id('flt_bar');
  }

  ordr_swtch_elm__(){

    // elm_by_id('ordr_swtch').textContent = this.ordr_swtch_elm_txt();
    elm_by_id('ordr_swtch').innerHTML = this.ordr_swtch_elm_html();
  }

  ordr_swtch_elm_html(){

    let txt;
    if      (this._video_ordr == 'view_cnt'){txt = this.swtch_elm_html('l');}
    else if (this._video_ordr == 'cdt'     ){txt = this.swtch_elm_html('r');}
    return txt;
  }

  swtch_elm_html(lr){

    let html;
    if       (lr == 'l'){
      html = '<img class="swtch" src="../img/swtch.l.svg">';
    }else if (lr == 'r'){
      html = '<img class="swtch" src="../img/swtch.r.svg">';
    }
    return html;
  }
  
  ordr_swtch_elm_txt(){

    let txt;
    if      (this._video_ordr == 'view_cnt'){txt = this.swtch_elm_txt('l');}
    else if (this._video_ordr == 'cdt'     ){txt = this.swtch_elm_txt('r');}
    return txt;
  }

  swtch_elm_txt(lr){

    let txt;
    if      (lr == 'l'){txt = '';}
    else if (lr == 'r'){txt = '';}
    return txt;
  }

  ordr_op_swtch_elm__(){

    // elm_by_id('ordr_op_swtch').textContent = this.ordr_op_swtch_elm_txt();
    elm_by_id('ordr_op_swtch').innerHTML = this.ordr_op_swtch_elm_html();
  }

  ordr_op_swtch_elm_html(){

    let op  = this._video_ordr_op;
    let txt = this.ordr_op_elm_html(op);
    return txt;
  }

  ordr_op_elm_html(op){

    let html;
    if      (op == 'asc'){
      html = '<img class="btn" src="../img/kaku03u.svg">';
    }else if(op == 'dsc'){
      html = '<img class="btn" src="../img/kaku03d.svg">';
    }
    return html;
  }
  
  ordr_op_swtch_elm_txt(){

    let op  = this._video_ordr_op;
    let txt = this.ordr_op_elm_txt(op);
    return txt;
  }

  ordr_op_elm_txt(op){

    let txt;
    if      (op == 'asc'){txt = '';}
    else if (op == 'dsc'){txt = '';}
    return txt;
  }

  // 
  // lst
  // 

  onclick(_video_id){ // old
    this.p(_video_id);
  }

  p(_video_id){ // alias
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

    let elm;
    for (let [idx, _video_id] of this._ply_video_id.entries()){

      elm = elm_by_id(_video_id);
      
      if (! elm){continue;}
      
      if (val){
        elm.classList.add(   "plying");
      }else{
        elm.classList.remove("plying");
      }
    }
  }

  ply_video_id__by_video_id(_video_id, lim){

    if (!lim){lim = 5;}

    this._ply_video_id = this.video_id_flt_slice(_video_id, lim)

    // log(this._ply_video_id);
  }

  // video req

  video__init(){
    
    this.video_file__();
    
    this.video__req();
  }
  
  video__req(){
  
    this.elm_ul__sndtmr();
    
    let slf = this;

    const xhr = new XMLHttpRequest();
    
    xhr.open("GET", this.video_file_url());
    
    xhr.setRequestHeader('If-Modified-Since', 'Thu, 01 Jun 1970 00:00:00 GMT');
    // xhr.setRequestHeader('If-Modified-Since', 'Wed, 31 Aug 2022 23:00:00 GMT');
    xhr.send();
    xhr.onreadystatechange = function(){

      if (!(xhr.readyState == 4 && xhr.status == 200)){return;}

      let video = JSON.parse(xhr.responseText);      
      slf.video__(video);

      slf.elm_ul__cre();

      // dont del because sync a
      slf.video_flt__();
      slf.video__srt();
      
      // log(slf._plyr_ready);
      if (slf._plyr_ready){
        // slf.ply_rnd();
      }
    }
  }

  flt_ply(force){ // todo name mod
    
    let flt_str = this.flt_bar_str().trim();

    if ((flt_str == this._flt_str_pre) && !force){return;}

    log("__flt :" + flt_str + ":" + this._flt_str_pre + ":");

    this.video_flt__(flt_str);

    this.video__srt();

    // this._flt_str_pre = flt_str;

    if ((!flt_str || flt_str == "") && !force){return;}

    this.ply_rnd();
  }

  ply_rnd(){

    if (this._video_id_flt.length == 0){return;}

    let video_id = ar_rnd(this._video_id_flt);

    this.plyr__ply_by_video_id(video_id);

    this.video_lst__scrl(video_id);
  }

  video_lst__scrl_top(){
    scrl(0, 0);
  }
  
  video_lst__scrl(video_id){

    if (! video_id){
      
      if (this._plying_video_id){
        video_id = this._plying_video_id;
        
      }else{return;}
    }

    let video_elm = elm_by_id(video_id);
    let video_top = video_elm.offsetTop;

    let hdr_h = elm_by_id('header').clientHeight;
    
    let scrl_y = video_top - ( hdr_h + 28 );

    scrl(0, scrl_y);
  }
  
  // 
  // plyr size
  // 
  
  static _plyr_size_def = {
    n: { w: 640, h: 250},
    l: { w: 992, h: 558},
  };
  
  plyr_size__(){
    
    let size = this.plyr_size();
    
    this._plyr.size__(size.w, size.h);
    elm('.plyr').style.width = size.w + 'px';
    
    this.hdr_h__();
    
    this._menu.w__(this._plyr_size_idx);
    
    this.plyr_size_swtch_elm__()
  }
  
  plyr_size(){
    
    let size_key = this._plyr_size_key[this._plyr_size_idx];
    
    return Song._plyr_size_def[size_key];
  }
  
  plyr_size__init(){
    
    this._plyr_size_key = Obj.keys(Song._plyr_size_def);
    
    this._plyr_size_idx = 0;
  }
  
  plyr_size__tgl(){
    
    this.plyr_size_idx__tgl();
    
    this.plyr_size__();
  }
  
  plyr_size_idx__tgl(){
    
    this._plyr_size_idx += 1;
    
    if (this._plyr_size_idx >= this._plyr_size_key.length){
      this._plyr_size_idx = 0;
    }
  }
  
  plyr_size_swtch_elm__(){
  
    // elm('#plyr_size_swtch').textContent = this.plyr_size_swtch_txt();
    elm('#plyr_size_swtch').innerHTML = this.plyr_size_swtch_html();
  }
  
  plyr_size_swtch_html(){
  
    let html;
    if       (this._plyr_size_idx == 0){
      html = '<img class="btn" src="../img/scrn.size.u.svg">';
    }else if (this._plyr_size_idx == 1){
      html = '<img class="btn" src="../img/scrn.size.d.svg">';
    }
    return html;
  }
  
  plyr_size_swtch_txt(){
  
    let txt;
    if       (this._plyr_size_idx == 0){
      txt = '';
    }else if (this._plyr_size_idx == 1){
      txt = '';
    }
    return txt;
  }
  
  hdr_h__(){ // n: 287px
    
    let hdr_h_crct = 37;
    
    let hdr_h = this.plyr_size().h + hdr_h_crct;
    // log(hdr_h);
    
    elm('.body_hdr_space').style.height = hdr_h + 'px';
  }
  
  video_file(){
    
    if (this._video_file){
      return this._video_file;
    }
    
    this.video_file__();
    
    return this._video_file;
  }
  
  video_file__(video_file){
    
    if (video_file){
      this._video_file = video_file;
      
    }else{
      this.video_file__init();
    }
  }
  
  static video_file_dflt = 'song_video/ltst.s.json';
  
  video_file__init(){

    let prm = this.url_prm();
    
    this._video_file = prm.f ? prm.f : Song.video_file_dflt;
  }
  
  static domain   = 'ooq.jp';
  static dir      = 'holo/song';
  static dir_data = 'data';
  
  url_dir(){
    
    return 'https://' + this.domain_dir();
  }
  
  url_dir_data(){
    
    return 'https://' + this.domain_dir_data();
  }
  
  domain_dir(){
    
    // let dir = Song.domain + "/" + Song.dir;
    let dir = Song.domain + this.url().pathname;
    log(dir);
    return dir;
  }
  
  domain_dir_data(){
    
    return this.domain_dir() + Song.dir_data;
  }
  
  video_file_url(){
    
    let video_file_url = this.url_dir_data() + '/' + this.video_file();
    return video_file_url;
  }
  
  url_prm(){

    if (this._url_prm){
      return this._url_prm;
    }
    
    this.url_prm__();
    
    return this._url_prm;
  }
  
  url_prm__(){
    
    let qery_str = this.qery_str();
    
    this._url_prm = u.url_qery_parse(qery_str);
  }
  
  qery_str(){
    
    if (this._qery_str){
      return this._qery_str;
    }
    
    this.qery_str__();
    
    return this._qery_str;
  }
  
  qery_str__(){
    
    this._qery_str = win.location.search;
  }
  
  url(){
    let url = new URL(window.location.href);
    return url;
  }
  
  plyr_ready__(){
    // log("plyr_ready__");
    
    this._plyr_ready = true;
  }
  
  st_ch(ev){
    let st = Plyr.st(ev.data);
    log('st_ch: ' + st);

    if       (st == 'ENDED'){
      // log('ENDED');
      this.ply_rnd();
      
    }else if (st == 'PLAYING'){
      // log('PLAYING');
      
      let t_elm;
      t_elm = elm_all('li.video_li span.plying');
      for (let [idx, _elm] of t_elm.entries()){
        _elm.textContent = '';
        _elm.classList.remove('plying');
      }
      
      let t_qery_str = ev.target.getVideoUrl().substring(29);
      // log(t_qery_str);
      
      this._plying_video_id = u.url_qery_parse(t_qery_str).v;
      // log(this._plying_video_id);
      
      t_elm = elm_by_id(this._plying_video_id).elm('span.ply_st');
      t_elm.classList.add('plying');
      
      // t_elm.textContent = '･'; // '*';
      t_elm.innerHTML = '<img class="plyingdot" src="../img/dot.svg">';
    }
    
    switch (st){
      case 'PAUSED'   :
      case 'BUFFERING':
      case 'PLAYING'  :
      case 'UNSTARTED':
        this._plyr.if_dly__cncl();
        break;
    }
  }
  
  clipboard__(str){
    
    this._clipboard = str;
    
    navigator.clipboard.writeText(this._clipboard);
  }
    
  clipboard__video_lst_lnk(){
    
    this.clipboard__(this.video_lst_lnk());
    
    this.video_lst_lnk_btn_anm();
  }
  
  video_lst_lnk(){
    
    this.video_lst_lnk__();
      
    return this._video_lst_lnk;
  }
  
  video_lst_lnk__(){
    
    let url_prm = [];
    
    let video_file = this.video_file();
    if (video_file != Song.video_file_dflt){
      url_prm.push('f=' + video_file);
    }
    
    let video_ordr = this.video_ordr();
    if (video_ordr != 'view_cnt'){
      url_prm.push('o=' + video_ordr);
    }
    
    let video_ordr_op = this.video_ordr_op();
    if (video_ordr_op != 'dsc'){
      url_prm.push('o_op=' + this.video_ordr_op());
    }
    
    let flt_bar_str = this.flt_bar_str();
    if (flt_bar_str != ''){
      url_prm.push('s='    + flt_bar_str);
    }
    
    this._video_lst_lnk = this.url_dir() + '?' + url_prm.join('&');
    log(this._video_lst_lnk);
  }
  
  video_lst_lnk_btn_anm(){
    
    let prm1 = {
      transform: 'scale(1.8)',
      easing   : 'ease-out',
    };
    
    let prm2 = {
      transform: 'scale(1)',
      easing   : 'ease-in',
    };
    
    let opt = {
      duration: 450,
      fill    : 'forwards',
      // easing : 'ease-out',
    };
    
    let btn_elm = elm('.lnk_btn');
    btn_elm.anm( [{}, prm1, prm2], opt );
  }
}

// 
// flt
// 

class Flt_word {
  
  // 
  // word match
  // 
  
  static is_match(str, word){ // flt main

    let ret = false;

    for (let [idx, word_and] of word.entries()){

      ret = Flt_word.is_match_or(str, word_and);
      
      if (! ret){break;}
    }
    return ret;
  }

  static is_match_or(str, word_or){

    let ret = false;

    for (let [idx, _word_or] of word_or.entries()){
      
      ret = Flt_word.is_str_match(str, _word_or);
      if (ret){break;}
    }
    return ret;
  }
  
  static is_str_match(str, word){

    let ret = false;

    str  = str.lower();
    word = word.lower();

    if (str.match_idx(word) >= 0){
      ret = true;
    }
    return ret;
  }

  // 
  // str split
  // 
  
  static split(str){

    let word_and = Flt_word.split_and(str);
    // log(word_and);

    for (let [idx, _word_and] of word_and.entries()){
    
      word_and[idx] = Flt_word.split_or(_word_and);
    }
    
    // log(word_and);
    return word_and;
  }
  
  static split_and(str){
    
    str = str.trim()
    
    // if (str == ''){return [];}
    
    let word_and = str.split(/\s+/g);
    return word_and;
  }
  
  static split_or(word_and){

    let split_char = ',';

    let exp = new RegExp('^' + split_char + '+|' + split_char + '+$', 'g');

    let word_or = word_and.replace(exp, '').split(split_char);
    return word_or;
  }
}

// 
// util
// 

class u {
  
  static url_qery_parse(qery_str){

    qery_str = qery_str.substring(1);

    let prms = qery_str.split('&');

    let prm = new Obj();
    let elm, key, val;
    for (let i = 0; i < prms.length; i++){

      elm = prms[i].split('=');
      key = decodeURIComponent(elm[0]);
      val = decodeURIComponent(elm[1]);
      prm[key] = val;
    }
    return prm;
  }
}

function rnd(min, max){

  let val = Math.floor(Math.random() * (max - min + 1) + min);
  return val
}

function ar_rnd(ar){

  let idx = ar_rnd_idx(ar);
  let val = ar[idx];
  return val;
}

function ar_rnd_idx(ar){

  let idx = rnd(0, ar.length - 1);
  return idx;
}

function ar_in(ar, val){

  let idx = ar.indexOf(val);
  let ret = idx >= 0 ? true : false ;
  return ret;
}

// main

let tag = doc.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
let js1 = doc.getElementsByTagName('script')[0];
js1.parentNode.insertBefore(tag, js1);

let menu = new Menu();
let song = new Song(menu);

// ytplyr

let video_id_dflt = [
  '68KV7JnrvDo', // sss mv 1
  'vQOPE6kHeoU', // sss mv 2
];

let ytplyr;
win.onYouTubeIframeAPIReady = function(){

  ytplyr = new YT.Player (
    'plyr',
    {
      // size n
      // width : '640',
      // height: '250',
      height: Song._plyr_size_def.n.h,
      
      // size l
      // width : '992',
      // height: '558',
      
      videoId: ar_rnd(video_id_dflt),
      
      playerVars: {
        autoplay: 0,
        controls: 1, 
        disablekb: 0,
        //mute:     1
        //playlist: "68KV7JnrvDo"
      },
      events: {
        // 'onReady':       Plyr.ready,
        'onReady':       song.plyr_ready__.bind(song),
        // 'onStateChange': song._plyr.st_ch.bind(song)
        'onStateChange': song.st_ch.bind(song)
      }
    }
  );
  song._plyr._ytplyr = ytplyr;
}

doc.onkeydown = function (e){
  // log("keydown : " + e.keyCode);
  
  switch (e.keyCode){
    case 191: // key: /
      if (doc.activeElement.id != 'flt_bar'){break;}
      e.preventDefault(); // ?
      song.flt_bar__focus();
      break;
    case  27: // key: <esc>
      // let plyr_elm = elm_by_id("plyr");
      // let if_plyr_elm = plyr_elm.contentWindow.document.querySelector("#player");
      // if_plyr_elm.focus();
      
      // song._plyr.getIframe().focus();
      break;
  }
};

