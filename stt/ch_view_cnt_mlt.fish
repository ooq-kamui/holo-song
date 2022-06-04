# fish

set mmbr_name \
  sora    \
  roboco  \
  mel     \
  aki     \
  matsuri \
  fubuki  \
  haato   \
  aqua    \
  shion   \
  ayame   \
  choco   \
  okayu   \
  korone  \
  azki    \
  suisei  \
  pekora  \
  flare   \
  noel    \
  marine  \
  kanata  \
  watame  \
  towa    \
  luna    \
  lamy    \
  nene    \
  botan   \
  polka   \
  laplus  \
  lui     \
  chloe   \
  iroha   \

#subaru 
#mio    
#miko   
#koyori 

for _mmbr_name in $mmbr_name
  echo $_mmbr_name
  fish ch_view_cnt.fish $_mmbr_name
end

