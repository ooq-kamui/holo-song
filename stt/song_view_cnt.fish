# fish

set dir_prj ~/doc/hoby/youtube/vtuber/hololive/prj

set dir_exe $dir_prj/stt
cd $dir_exe

set dir ../www/song/data
set cdt (date +"%Y-%m-%d.%H:%M")
set path_out_jsn  $dir/$cdt.json
set path_ltst_jsn $dir/ltst.jsn
#set cdt (date +"%Y-%m-%dT%H:%M")
#set path_out_jsn  $dir/t.$cdt.json
#set path_ltst_jsn $dir/t.ltst.jsn

lua song_view_cnt.lua | jq > $path_out_jsn
cp $path_out_jsn $path_ltst_jsn

# set path_out_txt  $dir/t.$cdt.txt
# set path_ltst_txt $dir/t.ltst.txt

# lua song_view_cnt_2_txt.lua $path_out_jsn | sort -r > $path_out_txt
# cp $path_out_txt $path_ltst_txt

