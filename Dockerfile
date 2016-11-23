FROM ruby:2.3.1

RUN apt-get update
RUN apt-get install -y postgresql-client cron

RUN gem install bundler

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/local/bin/dumb-init

WORKDIR /app
ADD . /app

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
