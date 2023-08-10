# fish

#set dir_prj  ~/doc/hoby/youtube/vtuber/hololive/prj
set dir_prj  ~/doc/hoby/youtube/vtuber/holo/prj
set dir_exe  $dir_prj/stt/ch
set dir_data $dir_exe/data
cd $dir_exe

function df_side_by_side

  echo "df" (basename $argv[1]) (basename $argv[2])
  
  #diff -sy -W 38 $argv
  diff -sy -W 38 (expand $argv[1] | psub) (expand $argv[2] | psub)
end

set path_ltst2 (ls $dir_data/cnt.????-??-??.txt | tail -2)

df_side_by_side $path_ltst2

