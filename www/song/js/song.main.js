
import {

  win,
  doc,
  elm,
  elm_all,
  elm_by_id,
  node_by_tmpl,
  Obj,
  // Array,
  // String,
  // Node,
  // Element,
  log,
  dly2,
  dly,
  dly__cncl,
  scrl
} from '../../js/alias.mdl.js';

import {

  Elm,
  Flt_word,
  u,
  rnd,
  ar_rnd,
  ar_rnd_idx,
  ar_in,
  lf_2_br
} from '../../js/lib.mdl.js';

import {

  Menu
} from './menu.mdl.js';

import {

  Plyr,
  Song
} from './song.mdl.js';

// main

let tag = doc.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
let js1 = doc.getElementsByTagName('script')[0];
js1.parentNode.insertBefore(tag, js1);

let menu = new Menu();

song = new Song(menu); // song : global

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

