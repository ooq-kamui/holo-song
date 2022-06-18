# fish

function tday_date

  date +"%Y-%m-%d"
end

function tday_time

  date +"%H:%M"
end

function tday_dt

  echo (tday_date).(tday_time)
end

function yday_date

  if test -n "$argv[1]"
    set num $argv[1]
  else
    set num 1
  end

  date -v-{$num}d +"%Y-%m-%d"
  #date -v-1d +"%Y-%m-%d"
end

function y1day_date

  yday_date 1
  #date -v-1d +"%Y-%m-%d"
end

function y2day_date

  yday_date 2
  #date -v-2d +"%Y-%m-%d"
end

