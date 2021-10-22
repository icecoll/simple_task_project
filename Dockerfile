FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
RUN gem install bundler:2.2.29
WORKDIR /app
COPY . .
RUN bundle install
RUN npm install yarn --global
RUN yarn install
RUN rails webpacker:compile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
