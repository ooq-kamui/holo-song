# fish

set dir_prj ~/doc/hoby/youtube/vtuber/hololive/prj

set dir_exe $dir_prj/stt
cd $dir_exe

set dir_www $dir_prj/www
set dir_data $dir_www/song/data

set path_file1 ( ls -t $dir_data/*.json | head -n 1 )
set path_file2 ( ls -t $dir_data/*.json | head -n 2 | tail -n 1 )
echo $path_file1 $path_file2

set sub_file ( basename $path_file1 .json ).-.( basename $path_file2 .json )
echo $sub_file

set path_out_jsn  $dir_data/$sub_file.json
echo $path_out_jsn
# exit

lua song_view_cnt_sub.lua $path_file1 $path_file2 | jq > $path_out_jsn

set path_ltst_jsn $dir_data/s.ltst.json
cp $path_out_jsn $path_ltst_jsn

# set path_out_txt  $dir_data/$sub_file.txt
# echo $path_out_txt
# lua song_view_cnt_2_txt.lua $path_out_jsn | sort -r > $path_out_txt

# set path_ltst_txt $dir_data/s.ltst.txt
# cp $path_out_txt $path_ltst_txt

