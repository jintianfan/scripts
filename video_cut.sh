#!/bin/sh
rm -rf /data/www/storage/videocut/gmxx/live
source /etc/profile
THUMB_DIR=/data/www/storage/videocut
cd /data/www/storage
for img in `find . -name '*.*'  |grep '.m3u8\|.mp4'|grep -v './videocut' ` 
do
  echo '====check image:'${img//.\//} 
  thumb_img=`echo $THUMB_DIR/${img//.\//}.jpg` 
  if [ ! -f "$thumb_img" ]; then
    echo '==need create thumb:'$thumb_img
    mkdir -p  `dirname $thumb_img`
    ffmpeg -i $img  -y -f  image2  -ss 1 -vframes 1 $thumb_img
  fi
done
