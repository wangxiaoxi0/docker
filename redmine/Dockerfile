FROM library/ubuntu:16.04
#ENV REDMINE_VERSION 3.3.8
#ENV REDMINE_DOWNLOAD_MD5 6ca9284fa1c3571f6c83dd0e0d0fec1b
#RUN wget -O redmine.tar.gz "https://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz"
#wget https://cache.ruby-china.com/pub/ruby/ruby-2.3.0.tar.gz
ADD *tar.gz sources.list /opt/
RUN mv /opt/sources.list /etc/apt/sources.list && \
	mv /opt/redmine-3.3.8 /usr/src/redmine && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
	sudo tzdata make \
	libssl-dev libssl1.0.0 libaio-dev libaio1 libmagickcore-dev libmagickwand-dev imagemagick libcurl4-openssl-dev \
	build-essential zlib1g-dev libreadline-dev libyaml-dev zlib1g-dev \
	mysql-client-5.7 libmysqlclient-dev \
	&& cd /opt/ruby-2.3.0 && \
	./configure && \
	make && \
	make install && \
 	rm -rf /opt/ruby-2.3.0 && \
	#mv /opt/*yml /usr/src/redmine/config/ && \
	sed -i s/rubygems.org/gems.ruby-china.com/g /usr/src/redmine/Gemfile && \
	cd /usr/src/redmine && \
	cp config/database.yml.example config/database.yml && \
    gem update && \
	gem install bundler && \
	bundle install --without development test && \
    cp Gemfile.lock Gemfile.lock.mysql2 && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

COPY docker-entrypoint.sh /
#ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /usr/src/redmine
#RUN gem install mysql2 && bundle package --all
EXPOSE 3000
#CMD bundle exec rails server -e production -b 0.0.0.0;
CMD ["/docker-entrypoint.sh"]