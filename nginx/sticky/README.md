nginx + sticky

#### 项目介绍
Dockerfile      1                   0
alpine          3.6                 3.7
nginx   1.12.1(1.13.12/1.14.0)      1.13.7
sticky          08a395c66e42        1.2.6


#### 运行命令

1. docker build -t wangxiaoxi/nginx_sticky .
2. docker run -d -v /home/wlj/nginx.conf:/etc/nginx/nginx.conf:ro -v /home/wlj/log:/var/log/nginx -p 80:80 --name my_nginx wangxiaoxi/nginx_sticky

#### 使用说明

1. 默认配置
    sticky方式负载均衡，三台服务器分流前端业务
    从1:192.168.179.132:10083
    从2:192.168.179.133:10083
    从3:192.168.179.133:10083
    主1:0.0.0.0:80