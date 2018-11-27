FROM tomcat:9-jre8
MAINTAINER wangxiaoxi

ENV OPENGROK_VERSION 1.1-rc75
ENV SRC_ROOT /src
ENV DATA_ROOT /data
ENV OPENGROK_WEBAPP_CONTEXT /
ENV OPENGROK_TOMCAT_BASE /usr/local/tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV CATALINA_BASE /usr/local/tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV CATALINA_TMPDIR /usr/local/tomcat/temp
ENV JRE_HOME /usr
ENV CLASSPATH /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar

ADD logging.properties /usr/local/tomcat/conf/logging.properties
ADD scripts /scripts

RUN echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib" > /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib" >> /etc/apt/sources.list && \
    apt-get -y update && apt-get install -y curl wget git subversion mercurial unzip inotify-tools \
    python3 python3-pip pkg-config autoconf build-essential && \
    wget -O /opengrok.tar.gz https://github.com/oracle/opengrok/releases/download/$OPENGROK_VERSION/opengrok-$OPENGROK_VERSION.tar.gz && \
    mkdir /opengrok && tar -zxvf /opengrok.tar.gz -C /opengrok --strip-components 1 && rm -f /opengrok.tar.gz && \
    mkdir $SRC_ROOT && \
    mkdir $DATA_ROOT && \
    mkdir -p /var/opengrok/etc/ && \
    ln -s $DATA_ROOT /var/opengrok && \
    ln -s $SRC_ROOT /var/opengrok/src && \
    python3 -m pip install /opengrok/tools/opengrok-tools* && \
    git clone https://github.com/universal-ctags/ctags.git /root/ctags && \
    cd /root/ctags && ./autogen.sh && ./configure && make && make install && \
    apt-get remove -y autoconf build-essential wget && apt-get -y autoremove && apt-get -y autoclean && \
    cd /root && rm -rf /root/ctags && \
    rm -rf /usr/local/tomcat/webapps/* && \
    opengrok-deploy /opengrok/lib/source.war /usr/local/tomcat/webapps/ROOT.war && \
    mkdir "/usr/local/tomcat/webapps/source" && \
    echo '<% response.sendRedirect("/"); %>' > "/usr/local/tomcat/webapps/source/index.jsp" && \
    sed -i -e 's/Valve/Disabled/' /usr/local/tomcat/conf/server.xml && \
    chmod -R +x /scripts

WORKDIR $CATALINA_HOME
EXPOSE 8080

CMD ["/scripts/start.sh"]