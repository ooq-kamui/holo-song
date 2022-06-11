# fish

source utl.fish
source df.fish

function is_same_tday_file_cnt_now_file

  set -l tday_file (tday_file)

  if [ -z $tday_file ]
    return 1
  end
  echo $tday_file $cnt_now_file

  if is_same_file $tday_file $cnt_now_file
    return 0
  else
    return 1
  end
end

# main

set yday_file (yday_file)
echo $yday_file

set st (diff -q $yday_file $cnt_now_file)
if [ -z "$st" ]
  echo "exit: yday_file == cnt_now_file"
  exit
end

if is_same_tday_file_cnt_now_file
  echo "is_same_tday_file_cnt_now_file: file_tday_file = cnt_now_file"
  exit
end

set tday_new_file $dir_data/cnt.(tday_dt).txt
echo $tday_new_file

cp $cnt_now_file $tday_new_file
echo "cp fin"

