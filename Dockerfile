FROM ruby:2.7.1-alpine3.11
MAINTAINER Ronan Duddy <ronanduddy@live.ie>

ENV BUILD_PACKAGES build-base
# ENV RUBY_PACKAGES

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    # apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY . .
RUN bundle install

# COPY . .
