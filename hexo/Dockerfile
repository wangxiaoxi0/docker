FROM node:alpine

WORKDIR /hexo

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk --update --no-cache add git openssh wget bash && \
    npm config set registry https://registry.npm.taobao.org && \
    npm install hexo-cli -g && \
    hexo init . && \
    npm install && \
    npm install hexo-deployer-git --save && \
    npm install hexo-renderer-less --save && \
    npm install hexo-generator-feed --save && \
    npm install hexo-generator-json-content --save && \
    wget https://github.com/yscoder/hexo-theme-indigo/archive/v1.7.0.tar.gz -O indigo.tar.gz && \
    mkdir themes/indigo && tar -zxvf indigo.tar.gz -C themes/indigo/ --strip-components 1 && \
    rm -rf indigo.tar.gz

EXPOSE 4000

CMD /bin/sh -c "hexo g && hexo s"