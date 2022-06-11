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

