source "https://rubygems.org"

gem "rails", "~> 5.0.0", ">= 5.0.0.1"
gem "puma", "~> 3.0"
gem "pg"
gem "therubyracer"

gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "bootstrap-sass", "~> 3.3.6"
gem "chartkick"
gem "active_link_to"

gem "jbuilder", "~> 2.5"
gem "haml-rails", "~> 0.9"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "typhoeus"
gem "active_interaction", "~> 3.4"

group :development do
  gem "web-console"
  # gem "listen", "~> 3.0.5"
  # gem "spring"
  # gem "spring-watcher-listen", "~> 2.0.0"

  gem "seedbank"

  gem "rubocop"

  gem "guard"
  gem "guard-rspec"
  gem "guard-bundler"
end

group :development, :test do
  gem "pry-byebug"

  # may be used in seeds
  gem "faker"

  # includes generators
  gem "rspec-rails"
  gem "factory_girl_rails"
end

group :test do
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "webmock"
end
