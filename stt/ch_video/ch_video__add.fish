# fish

set dir_prj ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_exe $dir_prj/stt/ch_video
cd $dir_exe

set dir_www  $dir_prj/www
set dir_data $dir_www/song/data/ch

set file1 (basename $argv[1])
set file2 (basename $argv[2])
set path_file1 $dir_data/$file1
set path_file2 $dir_data/$file2
# echo $path_file1 $path_file2

set path_tmp $path_file1.tmp.json
# echo $path_tmp

lua ch_video__add.lua $path_file1 $path_file2 | jq > $path_tmp

mv $path_tmp $path_file1
#cp $path_tmp $path_file1

