source "https://rubygems.org"

gem "rails", "~> 5.0.0", ">= 5.0.0.1"

gem "sqlite3"
gem "puma", "~> 3.0"

gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "therubyracer"

gem "jquery-rails"
gem "jbuilder", "~> 2.5"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
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
  # ==
end

group :test do
  gem "database_cleaner"
  gem "shoulda-matchers"
end
