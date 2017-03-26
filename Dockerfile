FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /ws-brepublica
WORKDIR /ws-brepublica
ADD Gemfile /ws-brepublica/Gemfile
ADD Gemfile.lock /ws-brepublica/Gemfile.lock
RUN bundle install
ADD . /ws-brepublica