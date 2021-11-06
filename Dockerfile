# Dockerfile.rails
FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /coreys-app
COPY Gemfile /coreys-app/Gemfile
COPY Gemfile.lock /coreys-app/Gemfile.lock
RUN bundle install
COPY . /coreys-app

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]