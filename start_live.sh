#!/bin/sh
echo "start convert param1:"$1
CNT=`ps -ef|grep ffmpeg |grep "$1"|grep -v grep|cut -c 9-15|wc -l`
echo "PS CNT"$CNT
DID=`docker ps |grep ffmpeg |awk  '{print $1}'`
IP=`docker inspect --format='{{.NetworkSettings.IPAddress}}' $DID`
echo "dockerID:"$DID' '$IP
ssh root@$IP << EOF
cd /data/script
sed '/$1/d' telnet_alive.txt>telnet_alive.txt.tmp
cat telnet_alive.txt.tmp>telnet_alive.txt
echo $1 >> telnet_alive.txt
if [ $CNT -eq 0 ]; then
(ffmpeg -v fatal -f rtsp -i rtsp://admin:abcd12345@"$1":554/h264/ch1/sub/av_stream -crf 30 -preset ultrafast -acodec aac -strict experimental -ar 44100 -ac 2 -b:a 96k -vcodec libx264 -r 25 -b:v 500k -s 640*480 -f hls -hls_time 5.0 -hls_list_size 5 -hls_wrap 5 /data/www/storage/gmxx/live/"$1".m3u8) &
echo 'end ffmpeg'
sh /data/script/video_cut.sh
fi
EOF
echo "success"
