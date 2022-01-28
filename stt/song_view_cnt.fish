# fish

set dir_prj ~/doc/hoby/youtube/vtuber/hololive/prj

set dir_exe $dir_prj/stt
cd $dir_exe

set dir ../www/song/data
set cdt (date +"%Y-%m-%d.%H:%M")
set path_out_jsn  $dir/$cdt.json
set path_ltst_jsn $dir/t.ltst.json

lua song_view_cnt.lua | jq > $path_out_jsn
cp $path_out_jsn $path_ltst_jsn

