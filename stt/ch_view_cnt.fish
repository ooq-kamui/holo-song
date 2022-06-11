# fish

set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_data $dir_prj/www/song/data/ch
set dir_exe  $dir_prj/stt
cd $dir_exe

source $dir_prj/ch_cnt/u.fish

set mmbr_name    $argv[1]
set path_out_jsn $dir_data/$mmbr_name.(tday_dt).json
echo $mmbr_name

lua ch_view_cnt.lua $mmbr_name | jq > $path_out_jsn

