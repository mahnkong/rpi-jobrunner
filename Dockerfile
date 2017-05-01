FROM mahnkong/docker-rpi-docker:v0.1.0

MAINTAINER Andreas Mahnke <mahnkong@gmx.de>

COPY . /jobrunner
WORKDIR /jobrunner/ruby

RUN apk update && \
    apk upgrade && \
    apk add bash ruby ruby-irb ruby-rake ruby-bundler && \
    rm -rf /var/cache/apk/* && \
    bundle install && \
    rake install

ENTRYPOINT ["jobrunner"]
