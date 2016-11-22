FROM ruby:2.3.1

RUN apt-get update
RUN apt-get install -y libpq-dev

WORKDIR /app
ADD . /app

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
