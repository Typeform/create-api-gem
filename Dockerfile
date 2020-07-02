FROM ruby:2.3.3-alpine
RUN apk update && apk upgrade
RUN apk add --no-cache git build-base bash
RUN gem install bundler -v '1.14'
RUN bundle install
