FROM ruby:2.5-alpine

RUN apk --no-cache add \
        g++ \
        gcc \
        libc-dev \
        make \
        nodejs \
    && gem install bundler

WORKDIR /srv/slate

COPY Gemfile Gemfile.lock ./

RUN bundle install

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]

EXPOSE 4567

COPY . ./
