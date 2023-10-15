// 
// alias
// 

// 
// win
// 

let win = window;

// 
// doc
// 

let doc = document;

function elm(slctr){
  return doc.querySelector(slctr);
}

function elm_all(slctr){
  return doc.querySelectorAll(slctr);
}

function elm_by_id(id){
  return doc.getElementById(id);
}

function node_by_tmpl(slctr){
  return elm(slctr).content.__clone(true);
}

// 
// obj
// 

let Obj = Object;
Obj.entry = Obj.entries

// 
// array
// 

Array.prototype.entry = function (){
  return this.entries();
};

Array.prototype.idx = function (){
  return this.indexOf();
};

Array.idx = Array.indexOf;

// 
// string
// 

String.prototype.match_idx = function (word){
  return this.indexOf(word);
};

String.prototype.lower = function (){
  return this.toLowerCase();
};

// 
// node
// 

Node.prototype.elm = function (slctr){
  return this.querySelector(slctr);
};

Node.prototype.elm_all = function (slctr){
  return this.querySelectorAll(slctr);
};

Node.prototype.__clone = function (slctr){
  return this.cloneNode(slctr);
};

Node.prototype.html__ = function (html){
  this.innerHTML = html;
  // return;
};

Node.prototype.txt__ = function (txt){
  this.textContent = txt;
  // return;
};

// 
// elm
// 

Element.prototype.attr__ = function (name, val){
  return this.setAttribute(name, val);
};

Element.prototype.attr__del = function (name){
  return this.removeAttribute(name);
};

Element.prototype.__add = function (elm){
  return this.appendChild(elm);
};

Element.prototype.__extnd = function (elm){
  return this.after(elm);
};

Element.prototype.evnt__add = function (evnt_name, fnc, flg){
  return this.addEventListener(evnt_name, fnc, flg);
};

Element.prototype.anm = function (keyfrm, opt){
  return this.animate(keyfrm, opt);
};

// 
// etc
// 

function log(str){
  console.log(str);
}

function dly2(msec, fnc, arg){
  
  let dly_id = setTimeout(fnc, msec, arg);
  return dly_id
}

function dly(fnc, msec, arg){
  
  let dly_id = setTimeout(fnc, msec, arg);
  return dly_id
}

function dly__cncl(dly_id){
  
  return clearTimeout(dly_id);
}

function scrl(x, y){
  scrollTo(x, y);
}

function elm__clone(tmpl_slctr){ -- old

  let tmpl      = elm(tmpl_slctr);
  let elm_clone = tmpl.content.cloneNode(true);
  return elm_clone
}

export {

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
};

