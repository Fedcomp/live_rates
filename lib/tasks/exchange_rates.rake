namespace :exchange_rates do
  desc "Fetch new rates for all supported currencies"
  task update: :environment do
    run = ExchangeRatesUpdater.run(currencies: Currency.all)

    Rails.application.logger.warning "Tinkoff api is unavailable" unless run.result
  end
end
