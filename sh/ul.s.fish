# fish

set s_dir_base dev/www/pri/holo
set l_dir_base ~/doc/hoby/youtube/vtuber/hololive/prj/www
set dir_data song/data
set s_dir_data $s_dir_base/$dir_data
set l_dir_data $l_dir_base/$dir_data

set l_path_date  (ls -t $l_dir_data/????-??-??.??:??.-.????-??-??.??:??.json)
set l_path_date1 $l_path_date[1]
#echo $l_path_date1
scp $l_path_date1 ooq@ooq.sakura.ne.jp:~/$s_dir_data

set l_path_ltst $l_dir_data/s.ltst.json
scp $l_path_ltst ooq@ooq.sakura.ne.jp:~/$s_dir_data

