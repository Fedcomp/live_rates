require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LiveRates
  # :nodoc:
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("lib").to_s
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.currency_rate_intervals = {
      weekly:    1.week,
      daily:     1.day,
      six_hours: 6.hours
    }

    config.currency_rate_default_interval = :daily
  end
end
