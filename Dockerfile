FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install
EXPOSE 3000
ENTRYPOINT ["./run.sh"]
CMD ["rails", "server"]
