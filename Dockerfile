FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler:2.2.29
WORKDIR /app
COPY . .
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
