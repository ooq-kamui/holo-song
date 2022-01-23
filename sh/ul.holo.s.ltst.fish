# fish

set liv_dir_base dev/www/pri/holo
set dev_dir_base ~/doc/hoby/youtube/vtuber/hololive/prj/www
set dir_data song/data
set liv_dir_data $liv_dir_base/$dir_data
set dev_dir_data $dev_dir_base/$dir_data

set dev_path_ltst $dev_dir_data/s.ltst.txt
set dev_path_date ( ls -t $dev_dir_data/s.t.*.* | head -n 2 )
# echo $dev_path_date

scp $dev_path_ltst ooq@ooq.sakura.ne.jp:~/$liv_dir_data
scp $dev_path_date ooq@ooq.sakura.ne.jp:~/$liv_dir_data

