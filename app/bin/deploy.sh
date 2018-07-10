#!/bin/bash
docker cp ~/Work/Jimmy/nginxLua/app openresty:/usr/local/
docker cp ~/Work/Jimmy/nginxLua/nginx_conf/nginx.conf openresty:/usr/local/openresty/nginx/conf/

docker exec -it openresty /bin/sh /usr/local/app/bin/reload.sh
