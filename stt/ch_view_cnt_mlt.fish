# fish

set mmbr_name \
  iroha   \

#  sora    \
#  roboco  \
#  miko    \
#  suisei  \
#  azki    \

#  fubuki  \
#  aki     \
#  haato   \
#  mel     \
#  matsuri \

#  aqua    \
#  subaru  \
#  ayame   \
#  choco   \
#  shion   \

#  mio     \
#  korone  \
#  okayu   \

#  pekora  \
#  flare   \
#  marine  \
#  noel    \

#  kanata  \
#  watame  \
#  towa    \
#  luna    \

#  nene    \
#  lamy    \
#  botan   \
#  polka   \

#  koyori  \
#  laplus  \
#  lui     \
#  chloe   \

for _mmbr_name in $mmbr_name
  #echo $_mmbr_name
  fish ch_view_cnt.fish $_mmbr_name
end

