# fish

set dir data

function tday_date

  date +"%Y-%m-%d"
end

function tday_time

  date +"%H:%M"
end

function tday_dt

  echo (tday_date).(tday_time)
end

# file

function day_files

  ls -r $dir/cnt.????-??-??.??:??.txt

  #set -l cnt_file_ptn 'cnt.????-??-??.??:??.txt'
  #ls -r "$dir/$cnt_file_ptn"
end

function day_files_ltst_2

  day_files | head -n 2 | sort
end

function yday_files

  set -l cnt_file_ptn 'cnt.20*.txt'
  set -l yday_ptn     (date -v -1d +"%Y%m%d 23:59")

  find $dir ! -newermt "$yday_ptn" -name "$cnt_file_ptn" | sort -r
end

function yday_file

  set -l yday_files ( yday_files )

  echo $yday_files[1]
end

function tday_files

  ls -t $dir/cnt.(tday_date).*.txt
end

function tday_file

  set -l tday_files (tday_files)

  if [ -z "$tday_files" ]
    return 1
  end

  echo $tday_files[1]
end

function is_exist_tday_file

  if tday_file
    return 0
  else
    return 1
  end
end

function is_same_file

  set -l st (diff -q $argv)
  #echo "is_same_file: $st"

  if [ -z "$st" ]
    return 0
  else
    return 1
  end
end

