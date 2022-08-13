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

doc.elm_slct = doc.querySelector; // old

function elm(slctr){
  return doc.querySelector(slctr);
}

function elm_by_id(id){
  return doc.getElementById(id);
}

// 
// Obj
// 

let Obj = Object;

// 
// node
// 

Node.prototype.elm_all = function (slctr){
  return this.querySelectorAll(slctr);
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

// 
// etc
// 

function log(str){
  console.log(str);
}

function dly(fnc, msec, arg){
  setTimeout(fnc, msec, arg);
}

function scrl(x, y){
  scrollTo(x, y);
}

function elm__clone(tmpl_slctr){

  let tmpl      = elm(tmpl_slctr);
  let elm_clone = tmpl.content.cloneNode(true);
  return elm_clone
}

