#!/bin/sh
source /etc/profile
for line in `cat telnet_alive.txt`
do
(ffmpeg -v fatal -f rtsp -i rtsp://admin:abcd12345@"$line":554/h264/ch1/sub/av_stream -crf 30 -preset ultrafast -acodec aac -strict experimental -ar 44100 -ac 2 -b:a 96k -vcodec libx264 -r 25 -b:v 500k -s 640*480 -f hls -hls_time 5.0 -hls_list_size 5 -hls_wrap 5 /data/www/storage/gmxx/live/"$line".m3u8) &
done
