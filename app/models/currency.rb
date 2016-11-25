class Currency < ApplicationRecord
  has_many :from_rates, foreign_key: :from_currency_id,
                        class_name: "CurrencyRate"

  validates :code, uniqueness: true, format: { with: /[A-Z]{3}/ }

  def average_rate_against(to_currency, interval: :daily)
    cache_key = "exchange_rate_for_#{code}_to_#{to_currency.code}_#{interval}"

    Rails.cache.fetch(cache_key, expires_in: 1.minute) do
      calculate_average_rate_against(to_currency, interval)
    end
  end

  private

  def calculate_average_rate_against(to_currency, interval)
    time_interval = Rails.application.config.currency_rate_intervals[interval]
    from_rates.select("AVG(buy) AS buy, AVG(sell) AS sell")
              .where(
                to_currency_id: to_currency.id,
                created_at: time_interval.ago..Time.current
              ).map { |r| { buy: r.buy, sell: r.sell } }.first
  end
end
