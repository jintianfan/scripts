#!/bin/bash
cd /data/www/storage
svn clean
svn update
cd /data/www/cdn
svn clean
svn update
cd /data/www/corich
svn clean
svn update

