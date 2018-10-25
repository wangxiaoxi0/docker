#!/bin/bash
cp Gemfile.lock.mysql2 Gemfile.lock
rake generate_secret_token
# remove PID file to enable restarting the container
rm -rf /usr/src/redmine/tmp/pids/server.pid
bundle check || bundle install --without development test
bundle exec rails server -e production -b 0.0.0.0;