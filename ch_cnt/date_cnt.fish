# fish

set date (
  ls data/*/cnt.*.txt |
  while read file
    basename $file |
    string sub -s 5 -l 10
  end |
  sort -u
)

set day_file (
  for day in $date

    set file_day (ls -t data/*/cnt.$day.*.txt)
    echo $file_day[1]
  end
)

lua date_cnt.lua $day_file

