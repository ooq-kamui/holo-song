# fish

set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_lib  $dir_prj/stt/lib
set dir_data $dir_prj/www/song/data/ch
set dir_exe  $dir_prj/stt/ch_video
cd $dir_exe

source $dir_lib/utl.fish

set mmbr_name    $argv[1]
set fr_date      $argv[2]
set path_out_jsn $dir_data/$mmbr_name.$fr_date.-.(tday_date).json
#set path_out_jsn $dir_data/$mmbr_name.(tday_dt).json
echo $path_out_jsn

lua ch_video.lua $mmbr_name $fr_date | jq > $path_out_jsn

