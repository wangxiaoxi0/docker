#!/usr/bin/env bash

docker rm -f $(docker ps -aq)
docker run --name=mysql-redmine -d -e 'DB_NAME=redmine_production' -e 'DB_USER=redmine' -e 'DB_PASS=password' -v /home/wangxiaoxi/redmine/mysql:/var/lib/mysql -p 3306:3306 sameersbn/mysql:5.7.22-1
echo "db is up"
docker run -d --rm -e 'DB_ADAPTER=mysql2' -e 'DB_HOST=192.168.60.133' -e 'DB_PORT=3306' -e 'DB_NAME=redmine_production' -e 'DB_USER=redmine' -e 'DB_PASS=password' -v /home/wangxiaoxi/redmine/redmine:/var/lib/data -p 10083:80 sameersbn/redmine:3.3.8
docker run -d --rm -e 'DB_ADAPTER=mysql2' -e 'DB_HOST=192.168.60.133' -e 'DB_PORT=3306' -e 'DB_NAME=redmine_production' -e 'DB_USER=redmine' -e 'DB_PASS=password' -v /home/wangxiaoxi/redmine/redmine:/var/lib/data -p 10084:80 sameersbn/redmine:3.3.8
docker run -d --rm -e 'DB_ADAPTER=mysql2' -e 'DB_HOST=192.168.60.133' -e 'DB_PORT=3306' -e 'DB_NAME=redmine_production' -e 'DB_USER=redmine' -e 'DB_PASS=password' -v /home/wangxiaoxi/redmine/redmine:/var/lib/data -p 10085:80 sameersbn/redmine:3.3.8
echo "3 redmine is up"
docker run -d -v /home/wangxiaoxi/redmine/nginx.conf:/etc/nginx/nginx.conf:ro -v /home/wangxiaoxi/log:/var/log/nginx -p 80:80 --name my_nginx wangxiaoxi/nginx_sticky:1.0
