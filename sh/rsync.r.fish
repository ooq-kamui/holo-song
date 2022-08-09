# fish

# -a  なるべくコピー元のファイルと同一条件でコピー
# -v  詳細を出力
# -e  ssh 指定
# --delete   転送元にないファイルは削除
# --dry-run  test 実行
# --exclude  除外
#            対象が複数の場合は--excludeを繰り返す
#            sync元の相対パスで指定

set prj   ~/doc/hoby/youtube/vtuber/hololive/prj
set l_dir $prj/www/song
set s_dir www/holo/song

rsync -av -e ssh --delete     \
  --exclude="data/"           \
  --exclude="tst/"            \
  --exclude="bk/"             \
  $l_dir/                     \
  ooq@ooq.sakura.ne.jp:~/$s_dir

#  --dry-run                   \

