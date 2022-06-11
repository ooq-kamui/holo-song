# fish

set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_data $dir_prj/www/song/data/ch
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
  echo $_mmbr_name
  set path_file1 $dir_data/$_mmbr_name.json
  set path_file2 $dir_data/$_mmbr_name.2022-06-12.03:19.json
  #set path_file2 $dir_data/$_mmbr_name.2022-06-11.09:40.json

  fish ch_video__add.fish $path_file1 $path_file2
end

