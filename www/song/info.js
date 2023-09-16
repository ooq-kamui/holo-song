
class Info {

  constructor(){

    this._itm;

    this.itm__init();
  }

  itm__init(){

    this._itm = [];

    this.itm__req();
  }

  static _domain    = 'ooq.jp';
  static _dir       = 'holo/song/data/info';
  static _file_name = 'info.json';

  info_url(){

    let url = 'https://' + Info._domain + '/'
            + Info._dir + '/' + Info._file_name;
    return url;
  }

  itm__req(){

    let slf = this;

    const xhr = new XMLHttpRequest();
    
    xhr.open("GET", this.info_url());

    xhr.setRequestHeader('If-Modified-Since', 'Thu, 01 Jun 1970 00:00:00 GMT');
    xhr.send();
    xhr.onreadystatechange = function(){

      if (!(xhr.readyState == 4 && xhr.status == 200)){return;}

      let t_itm = JSON.parse(xhr.responseText);      
      slf.itm_lst__add(t_itm);
    }
  }

  itm_lst__add(itm){

    for (let [idx, _itm] of itm.entries()){

      this.itm__add(_itm);
    }
  }

  itm__add(itm){

    this._itm.push(itm);

    this.itm_elm__add(itm);
  }

  itm_elm__add(itm){

    let info_itm_node = node_by_tmpl('#info_itm_tmpl');

    info_itm_node.elm('.info_itm_txt').txt__(itm.txt);

    elm('#info_lst').__add(info_itm_node);
  }
}

let info = new Info();


// 
// taittsuu
// 

function share_taittsuu(){

  let txt = "hololive ホロライブ 歌動画 週間 再生数 "
          + "https://ooq.jp/holo/song/";

  let url = "https://taittsuu.com/share?text=" + encodeURI(txt);
  window.open(url);
}

