# fish
# 
# nxt when 2022-06-13
# fish ch_video_mlt.fish 2022-06-12

set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_lib  $dir_prj/stt/lib

set dir_exe  $dir_prj/stt/ch_video
cd $dir_exe

set fr_date $argv[1]

source $dir_lib/mmbr.fish

for _mmbr_name in $mmbr_name
  #echo $_mmbr_name
  fish ch_video.fish $_mmbr_name $fr_date
end

