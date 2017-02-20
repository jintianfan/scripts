#!/bin/bash
rm -rf /data/www/storage/gmxx/live/*
echo `date`'_execute heartbeat.sh'>>/data/logs/cron.log
cd /data/script
sh kill_ff.sh
sleep 5
sh ff.sh
