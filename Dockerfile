FROM ruby

ADD . /app/
RUN gem install slack-big-emoji

