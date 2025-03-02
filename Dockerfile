FROM ruby:3.3.5-alpine

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN apk update && \
    apk add --no-cache build-base ruby-dev libressl-dev poppler-utils imagemagick ghostscript

COPY . .

RUN bundle install

ENTRYPOINT ["ruby", "bin/cli", "process"]
