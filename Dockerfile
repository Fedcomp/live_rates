FROM ruby:2.3.1

RUN gem install bundler

WORKDIR /app
ADD . /app

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
