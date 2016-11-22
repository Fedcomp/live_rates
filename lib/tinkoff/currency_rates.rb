module Tinkoff
  # Fetches exchange rates from Tinkoff api
  class CurrencyRates
    API_URL = "https://www.tinkoff.ru/api/v1/currency_rates/".freeze

    class << self
      # Fetch exchange rates for specified currency
      # @param retries [Integer] Amount of http retries
      # @param retry_time [Integer] Amount of seconds to wait after each request
      # @return [Array]
      #   [{ from:, to:, buy:, :sell }]
      #   or nil if api error
      def fetch(retries: 3, retry_time: 1)
        json = fetch_api(retries, retry_time)
        return if json.nil?

        process_results(json)
      end

      private

      def process_results(json)
        json.dig("payload", "rates")
            .select { |e| e.dig("category") == "DepositPayments" }
            .map do |e| # name => {buy: 1, sell: 1}
              {
                from: e.dig("fromCurrency", "name").to_sym,
                to:   e.dig("toCurrency", "name").to_sym,
                buy:  e.dig("buy"),
                sell: e.dig("sell")
              }
            end
      end

      def fetch_api(retries, retry_time)
        retries.times do |i|
          resp = Typhoeus.get(API_URL)
          break JSON.parse(resp.body) if resp.success?
          break if i == retries - 1 # if last retry, return nil

          # try again
          sleep retry_time
          next
        end
      end

    end
  end
end
