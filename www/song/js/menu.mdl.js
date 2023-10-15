
import {

  win,
  doc,
  elm,
  elm_all,
  elm_by_id,
  node_by_tmpl,
  Obj,
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


class Menu {

  constructor(){
    
    this.__cre();
  }
  
  __cre(){
    
    let menu_l_node = node_by_tmpl('#menu_l_tmpl');
    
    elm('#hdr_l').__add(menu_l_node);
    
    let menu_r_node = node_by_tmpl('#menu_r_tmpl');
    elm('#hdr_r').__add(menu_r_node);
    
    this.w__(0);
  }
  
  static w_def = [ // idx: plyr_size_idx
    230, // 300,
    100,
  ];
  
  w__(idx){
    
    let w = Menu.w_def[idx]
    elm('#hdr_l').style.width = w + 'px';
    elm('#hdr_r').style.width = w + 'px';
  }
}

export {

  Menu
};

