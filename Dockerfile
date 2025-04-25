FROM ruby

ADD . /app/
RUN cd /app && gem build && gem install slack-big-emoji-*.gem

