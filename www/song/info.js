
class Info {

  static _itm_tst = [
    {
      "ts" : "2023-09-15.00:00",
      "txt": "dev_is regloss に対応しました"
    },
    {
      "ts" : "2023-09-17.00:00",
      "txt": "ch video list は廃止する予定です"
    }
  ];

  constructor(){

    this._itm;

    this.itm__init();
  }

  itm__init(){

    this._itm = [];

    let t_itm = Info._itm_tst;

    for (let [idx, _itm] of t_itm.entries()){

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

