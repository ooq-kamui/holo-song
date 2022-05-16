# fish

function diff_sbs

  echo "diff $argv"
  diff -sy -W 38 $argv
  #echo "diff -sy -W 38 $argv"
end

#diff_sbs $argv

