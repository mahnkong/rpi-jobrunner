FROM hypriot/rpi-alpine:3.5

MAINTAINER Andreas Mahnke <mahnkong@gmx.de>

ENV RCLONE_VERSION v1.36

COPY . /jobrunner

WORKDIR /jobrunner/ruby

RUN apk update && \
    apk upgrade && \
    apk add bash ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler git && \
    rm -rf /var/cache/apk/* && \
    bundle install && \
    rake install

ENTRYPOINT ["jobrunner"]
