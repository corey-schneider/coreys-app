# Dockerfile.rails
FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y \
    nodejs postgresql-client yarn \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn
WORKDIR /coreys-app

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile /coreys-app/Gemfile
COPY Gemfile.lock /coreys-app/Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle install --without development test
COPY . /coreys-app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]