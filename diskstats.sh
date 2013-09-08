#!/bin/bash -x

# this script will constantly run in the background, and once every $WAIT seconds
# take a reading from $FILE, then send those readings to a local/remote redis server

WAIT=30
HOST=localhost
PORT=6379
HOSTNAME=localhost.localnetwork
DEVICE=diskstats
FILE=/proc/diskstats
DATE=`date +"%y%m%d"`

while :
do

TIME=`date "+%s"`
cat $FILE | while read line; do             
echo "RPUSH $HOSTNAME.$DATE.$DEVICE \"$TIME $line\"" | /root/bash-redis/redis-2.6.14/src/redis-cli -h $HOST -p $PORT
done

sleep $WAIT
done

