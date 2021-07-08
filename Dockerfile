ARG RUBY_VERSION=2.6.7
FROM ruby:2.6.7
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs\
                       mariadb-server
ENV LANG C.UTF-8 
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
