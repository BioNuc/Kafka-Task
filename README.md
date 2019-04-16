# README

This README would normally document whatever steps are necessary to get the
application up and running.

- Install Ruby version stated in Gemfile (ruby 2.6.2)

- Install Bundler version stated in Gemfile.lock (2.0.1)

- Install Kafka (you can use this tutorial as a guide https://tecadmin.net/install-apache-kafka-ubuntu/)

- To start Kafka go inside Kafka Binary and in terminal
 ./bin/zookeeper-server-start.sh config/zookeeper.properties
 ./bin/kafka-server-start.sh config/server.properties

- To start Rails application go to application folder and in terminal
  bundle exec rails server
