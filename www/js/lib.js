
// 
// elm
// 

class Elm {
  
  static __hvr_dsp(hvr_elm, dsp_elm){
    
    hvr_elm.evnt__add(
      'mouseover',
      function (ev){
        // log("mouseover");
        dsp_elm.style.opacity    = 1;
        dsp_elm.style.visibility = 'visible';
      },
      false
    );

    hvr_elm.evnt__add(
      'mouseleave',
      function (ev){
        // log("mouseleave");
        dsp_elm.style.opacity    = 0;
        dsp_elm.style.visibility = 'hidden';
      },
      false
    );
  };
  
  static __tooltip(hvr_elm, txt){
    
    let dsp_node = node_by_tmpl('#tooltip_tmpl');
    let dsp_elm  = dsp_node.elm('span');
    
    let html = txt.replace(/\n/g, '<br>');
    dsp_elm.html__(html);
    log(dsp_elm);
    
    hvr_elm.__extnd(dsp_node);
    
    Elm.__hvr_dsp(hvr_elm, dsp_elm);
  };
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

