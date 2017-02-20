#!/bin/sh
#rm -rf /data/www/storage/videocut/gmxx/live
echo `date`'_execute thumb.sh'>>/data/logs/cron.log
THUMB_DIR=/data/www/storage/thumb
cd /data/www/storage
for img in `find . -name '*.*'  |grep '.jpg\|.png\|.jpeg' |grep -v './thumb'` 
do
  echo '====check image:'${img//.\//} 
  thumb_img=`echo $THUMB_DIR/${img//.\//}` 
  if [ ! -f "$thumb_img" ]; then
    echo '==need create thumb:'$thumb_img
    mkdir -p  `dirname $thumb_img`
   convert -sample 25%x25% $img $thumb_img
  fi
  if [ `ls -l $img |awk '{print $5}'` -gt $((1024*1024)) ]
  then
  echo 'compress big img:'${img}
   convert -sample 50%x50% $img $img
  fi
done
