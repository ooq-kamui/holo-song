
let mmbr = [
  {
    "sora": {
      "ch_id": "UCp6993wxpyDPHUpavwDFqgg",
      "tw_id": "tokino_sora"
    },
    "roboco": {
      "ch_id": "UCDqI2jOz0weumE8s7paEk6g",
      "tw_id": "robocosan"
    },
    "miko": {
      "ch_id": "UC-hM6YJuNYVAmUWxeIr9FeA",
      "tw_id": "sakuramiko35"
    },
    "suisei": {
      "ch_id": "UC5CwaMl1eIgY8h02uZw7u8A",
      "tw_id": "suisei_hosimati"
    },
    "azki": {
      "ch_id": "UC0TXe_LYZ4scaW2XMyi5_kw",
      "tw_id": "azki_vdiva"
    },
  },
  {
    "fubuki": {
      "ch_id": "UCdn5BQ06XqgXoAxIhbqw5Rg",
      "tw_id": "shirakamifubuki"
    },
    "aki": {
      "ch_id": "UCFTLzh12_nrtzqBPsTCqenA",
      "tw_id": "akirosenthal"
    },
    "haato": {
      "ch_id": "UC1CfXB_kRs3C-zaeTG3oGyg",
      "tw_id": "akaihaato"
    },
    "mel": {
      "ch_id": "UCD8HOxPs4Xvsm8H0ZxXGiBw",
      "tw_id": "yozoramel"
    },
    "matsuri": {
      "ch_id": "UCQ0UDLQCjY0rmuxCDE38FGg",
      "tw_id": "natsuiromatsuri"
    },
  },
  {
    "aqua": {
      "ch_id": "UC1opHUrw8rvnsadT-iGp7Cg",
      "tw_id": "minatoaqua"
    },
    "subaru": {
      "ch_id": "UCvzGlP9oQwU--Y0r9id_jnA",
      "tw_id": "oozorasubaru"
    },
    "ayame": {
      "ch_id": "UC7fk0CB07ly8oSl0aqKkqFg",
      "tw_id": "nakiriayame"
    },
    "choco": {
      "ch_id": "UC1suqwovbL1kzsoaZgFZLKg",
      "tw_id": "yuzukichococh"
    },
    "shion": {
      "ch_id": "UCXTpFs_3PqI41qX2d9tL2Rw",
      "tw_id": "murasakishionch"
    },
  },
  {
    "mio": {
      "ch_id": "UCp-5t9SrOQwXMU7iIjQfARg",
      "tw_id": "ookamimio"
    },
    "korone": {
      "ch_id": "UChAnqc_AY5_I3Px5dig3X1Q",
      "tw_id": "inugamikorone"
    },
    "okayu": {
      "ch_id": "UCvaTdHTWBGv3MKj3KVqJVCw",
      "tw_id": "nekomataokayu"
    },
  },
  {
    "flare": {
      "ch_id": "UCvInZx9h3jC2JzsIzoOebWg",
      "tw_id": "shiranuiflare"
    },
    "marine": {
      "ch_id": "UCCzUftO8KOVkV4wQG1vkUvg",
      "tw_id": "houshoumarine"
    },
    "noel": {
      "ch_id": "UCdyqAaZDKHXg4Ahi7VENThQ",
      "tw_id": "shiroganenoel"
    },
    "pekora": {
      "ch_id": "UC1DCedRgGHBdm81E1llLhOQ",
      "tw_id": "usadapekora"
    },
  },
  {
    "kanata": {
      "ch_id": "UCZlDXzGoo7d44bwdNObFacg",
      "tw_id": "amanekanatach"
    },
    "watame": {
      "ch_id": "UCqm3BQLlJfvkTsX_hvm0UmA",
      "tw_id": "tsunomakiwatame"
    },
    "towa": {
      "ch_id": "UC1uv2Oq6kNxgATlCiez59hw",
      "tw_id": "tokoyamitowa"
    },
    "luna": {
      "ch_id": "UCa9Y57gfeY0Zro_noHRVrnw",
      "tw_id": "himemoriluna"
    },
  },
  {
    "nene": {
      "ch_id": "UCAWSyEs_Io8MtpY3m-zqILA",
      "tw_id": "momosuzunene"
    },
    "lamy": {
      "ch_id": "UCFKOVgVbGmX65RxO3EtH3iw",
      "tw_id": "yukihanalamy"
    },
    "polka": {
      "ch_id": "UCK9V2B22uJYu3N7eR_BT9QA",
      "tw_id": "omarupolka"
    },
    "botan": {
      "ch_id": "UCUKD-uaobj9jiqB-VXt71mA",
      "tw_id": "shishirobotan"
    },
  },
  {
    "koyori": {
      "ch_id": "UC6eWCld0KwmyHFbAqK3V-Rw",
      "tw_id": "hakuikoyori"
    },
    "laplus": {
      "ch_id": "UCENwRMx5Yh42zWpzURebzTw",
      "tw_id": "laplusdarknesss"
    },
    "lui": {
      "ch_id": "UCs9_O1tRPMQTHQ-N_L6FU2g",
      "tw_id": "takanelui"
    },
    "chloe": {
      "ch_id": "UCIBY1ollUsauvVi4hW4cumw",
      "tw_id": "sakamatachloe"
    },
    "iroha": {
      "ch_id": "UC_vMYWcDjmfdpH6r4TTn1MQ",
      "tw_id": "kazamairohach"
    }
  }
];
// console.log(mmbr);

// alias
let doc = document;
doc.elm_slct = doc.querySelector;

let profile_elm_tmpl = doc.elm_slct('#profile_tmpl');
let gen_elm_tmpl     = doc.elm_slct('#gen_tmpl');
let profile_lst      = doc.elm_slct('#profile_lst');

for (let [idx, gen] of mmbr.entries()){

  let gen_elm = gen_elm_tmpl.content.cloneNode(true);

  for (let [name, profile] of Object.entries(gen)){

    let profile_elm = profile_elm_tmpl.content.cloneNode(true);

    let a_elm = profile_elm.querySelectorAll("a");
    a_elm[0].textContent = name;
    a_elm[0].href = "./?o=cdt&f=" + name + ".json";
    a_elm[1].href = "https://www.youtube.com/channel/" + profile.ch_id;
    a_elm[2].href = "./?o=cdt&f=" + name + ".json";
    a_elm[3].href = "https://twitter.com/" + profile.tw_id;

    let img_elm    = profile_elm.querySelectorAll("img");
    img_elm[1].src = "/holo/mmbr/jp/" + name + "/profile.jpg";

    // console.log(profile_elm);

    let gen_div_elm = gen_elm.querySelectorAll("div");
    gen_div_elm[0].appendChild(profile_elm);
  }
  profile_lst.appendChild(gen_elm);
}

