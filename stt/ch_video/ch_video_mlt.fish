# fish

set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_exe  $dir_prj/stt/ch_video
cd $dir_exe

set mmbr_name \
  sora    \
  roboco  \
  miko    \
  suisei  \
  azki    \
  fubuki  \
  aki     \
  haato   \
  mel     \
  matsuri \
  aqua    \
  subaru  \
  ayame   \
  choco   \
  shion   \
  mio     \
  korone  \
  okayu   \
  pekora  \
  flare   \
  marine  \
  noel    \
  kanata  \
  watame  \
  towa    \
  luna    \
  nene    \
  lamy    \
  botan   \
  polka   \
  koyori  \
  laplus  \
  lui     \
  chloe   \
  iroha   \

for _mmbr_name in $mmbr_name
  #echo $_mmbr_name
  fish ch_video.fish $_mmbr_name
end

