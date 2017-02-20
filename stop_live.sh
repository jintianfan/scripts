#!/bin/sh
#stop live video by ip
echo "stop convert param1:"$1
CNT=`ps -ef|grep ffmpeg |grep "$1"|grep -v grep|cut -c 9-15|wc -l`
echo "PS CNT"$CNT
DID=`docker ps |grep ffmpeg |awk  '{print $1}'`
IP=`docker inspect --format='{{.NetworkSettings.IPAddress}}' $DID`
echo "dockerID:"$DID' '$IP
ssh root@$IP << EOF
echo "ssh param:"$1
cd /data/script
sed '/$1/d' telnet_alive.txt>telnet_alive.txt.tmp
cat telnet_alive.txt.tmp>telnet_alive.txt
if [ $CNT -gt 0 ]; then
ps -ef|grep ffmpeg |grep $1|grep -v grep|cut -c 9-15|xargs kill -9    
fi
EOF
echo success;
