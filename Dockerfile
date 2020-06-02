FROM ruby:2.7.1-alpine3.11
MAINTAINER Ronan Duddy <ronanduddy@live.ie>

ENV BUILD_PACKAGES build-base less git

RUN apk update && \
    apk upgrade && \
    apk add --no-cache $BUILD_PACKAGES

WORKDIR /usr/src/app

COPY . .
RUN bundle install
