class ExchangeRatesUpdater < ActiveInteraction::Base
  array :currencies do
    object class: Currency
  end

  integer :retries, default: 3
  integer :retry_time, default: 1

  def execute
    return unless rates

    models.map(&:save!) # Also may use ActiveRecord import gem
    models
  end

  private

  # @return [Hash]
  #  key - currency code, value - id in currency table.
  #  example: { EUR: 1,  USD: 2 }
  def allowed_codes
    @codes ||= currencies.map do |c|
      { c.code.to_sym => c.id }
    end.reduce({}, :merge)
  end

  def rates
    @rates ||= begin
      results = Tinkoff::CurrencyRates
                .fetch(retries: retries, retry_time: retry_time)

      # select only currencies we know
      results&.select do |rate|
        rate[:from].in?(allowed_codes.keys) && rate[:to].in?(allowed_codes.keys)
      end
    end
  end

  def models
    @models ||= rates.map do |rate|
      CurrencyRate.new from_currency_id: allowed_codes[rate[:from]],
                       to_currency_id: allowed_codes[rate[:to]],
                       buy: rate[:buy],
                       sell: rate[:sell]
    end
  end
end
