# fish

set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_lib  $dir_prj/stt/lib
set dir_exe  $dir_prj/stt/ch_video
cd $dir_exe

source $dir_lib/utl.fish

set fr_date (yday_date) #2022-06-13
set to_date (tday_date)
set term_date $fr_date.-.$to_date
echo $term_date

fish ch_video_mlt.fish $fr_date

fish ch_video__add_mlt.fish $term_date

fish ul_ch_video_mlt.fish

