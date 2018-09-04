#!/bin/bash
docker cp ../../../app openresty:/usr/local/
docker cp ../../../nginx_conf/nginx.conf openresty:/usr/local/openresty/nginx/conf/

docker exec -it openresty /bin/sh /usr/local/app/bin/reload.sh
