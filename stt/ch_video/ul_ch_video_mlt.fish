# fish

set svr_dir_base    dev/www/pri/holo
set svr_dir_data    $svr_dir_base/song/data/ch

set lcl_dir_prj     ~/doc/hoby/youtube/vtuber/hololive/prj
set lcl_dir_lib     $lcl_dir_prj/stt/lib
set lcl_dir_data    $lcl_dir_prj/www/song/data
set lcl_dir_data_ch $lcl_dir_data/ch
cd $lcl_dir_data_ch

source $lcl_dir_lib/mmbr.fish

for _mmbr_name in $mmbr_name
  #echo $_mmbr_name
  set path_file $lcl_dir_data_ch/$_mmbr_name.json

  scp $path_file ooq@ooq.sakura.ne.jp:~/$svr_dir_data
end

