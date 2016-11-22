require "rails_helper"

describe Tinkoff::CurrencyRates do
  describe "#fetch" do
    let(:expected_exchange_rates_for_default) do
      # from fixture above
      [
        { from: :USD, to: :RUB, buy: 62.7, sell: 65.25 },
        { from: :USD, to: :GBP, buy: 0.78125, sell: 0.8130081301 },
        { from: :USD, to: :EUR, buy: 0.9259259259, sell: 0.9615384615 },
        { from: :EUR, to: :RUB, buy: 66.6, sell: 69.35 },
        { from: :EUR, to: :USD, buy: 1.04, sell: 1.08 },
        { from: :EUR, to: :GBP, buy: 0.8333333333, sell: 0.8695652174 },
        { from: :GBP, to: :RUB, buy: 78.45, sell: 81.65 },
        { from: :GBP, to: :EUR, buy: 1.15, sell: 1.2 },
        { from: :GBP, to: :USD, buy: 1.23, sell: 1.28 }
      ]
    end

    let(:http_success_body) do
      Rails.root.join("spec/fixtures/http/tinkoff/currency_rates.json").read
    end

    context "on success" do
      before do
        stub_request(:get, "https://www.tinkoff.ru/api/v1/currency_rates/")
          .to_return(status: 200, body: http_success_body)
      end

      it "returns all currency rates by default" do
        expect(described_class.fetch).to eq(expected_exchange_rates_for_default)
      end
    end

    context "on api error" do
      it "retries 3 times by default" do
        stub_request(:get, "https://www.tinkoff.ru/api/v1/currency_rates/")
          .to_timeout.then
          .to_return(status: 500, body: "{}").then
          .to_return(status: 200, body: http_success_body)

        expect(described_class.fetch(retries: 3, retry_time: 0))
          .to eq(expected_exchange_rates_for_default)
      end

      it "retries specified amount of times" do
        stub_request(:get, "https://www.tinkoff.ru/api/v1/currency_rates/")
          .to_timeout.then
          .to_return(status: 500, body: "{}").then
          .to_return(status: 500, body: "{}").then
          .to_timeout.then
          .to_return(status: 200, body: http_success_body)

        expect(described_class.fetch(retries: 5, retry_time: 0))
          .to eq(expected_exchange_rates_for_default)
      end

      it "returns nil after all retries" do
        stub_request(:get, "https://www.tinkoff.ru/api/v1/currency_rates/")
          .to_return(status: 500)

        expect(described_class.fetch(retry_time: 0)).to be_nil
      end

    end
  end
end
