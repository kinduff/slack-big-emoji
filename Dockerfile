FROM ruby

ADD . /app/
RUN cd /app && gem build && gem install slack-big-emoji-*.gem
FROM ruby:slim

WORKDIR /app

COPY Gemfile* *.gemspec /app/
RUN gem install bundler && bundle install

COPY . /app/
RUN gem build slack-big-emoji-*.gemspec && \
    gem install slack-big-emoji-*.gem
