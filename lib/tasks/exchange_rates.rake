namespace :exchange_rates do
  desc "Fetch new exchange rates for all supported currencies"
  task update_daemon: [:environment, :log_to_stdout] do
    Rails.logger.info "Starting exchange rates updater daemon"

    loop do
      Rails.logger.info "Fetching new exchange rates"
      run = ExchangeRatesUpdater.run(currencies: Currency.all)

      Rails.logger.warning "Tinkoff api is unavailable" unless run.result
      Rails.logger.info "Sleeping next 15 minutes"
      sleep 15.minutes # data fetching every 15 minutes is optimal
    end
  end
end
