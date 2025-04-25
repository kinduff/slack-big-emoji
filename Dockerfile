FROM ruby

WORKDIR /app
COPY . /app/

RUN gem install bundler && bundle install

