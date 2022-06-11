# fish

set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_data $dir_prj/www/song/data
set dir_exe  $dir_prj/stt/song_video
cd $dir_exe

set cdt ( date +"%Y-%m-%d.%H:%M" )
set path_out_jsn  $dir_data/$cdt.json
set path_ltst_jsn $dir_data/t.ltst.json

lua song_video.lua | jq > $path_out_jsn
cp $path_out_jsn $path_ltst_jsn

