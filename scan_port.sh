#!/bin/sh
echo -n "" > telnet_result.txt
PORT="$2"
count=0 
for((i=1;i<=254;i++)) 
do
    ((count++)) 
    echo "count=$count"
    # 关键代码，1s自动结束telnet 
    (telnet "$1."$i $PORT >> telnet_result.txt) &(sleep 1;) &
done
# 根据结果判断出正常可以ping通的ip 
cat telnet_result.txt | grep -B 1 \] | grep [0-9] | awk '{print $3}' | cut -d '.' -f 1,2,3,4|sort > telnet_alive.txt
