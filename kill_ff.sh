#!/bin/bash
ps -ef|grep ffmpeg |grep -v grep|cut -c 9-15|xargs kill -9    
