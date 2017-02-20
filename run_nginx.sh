#!/bin/bash
docker run -d -p 80:80 --privileged=true -v /data:/data -v /data/nginx/nginx.conf:/etc/nginx/nginx.conf nginx:1.9
