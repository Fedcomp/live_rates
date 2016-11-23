require "rails_helper"

describe ExchangeRatesUpdater do
  let(:http_success_body) do
    Rails.root.join("spec/fixtures/http/tinkoff/currency_rates.json").read
  end

  let(:currencies) do
    [
      create(:currency, code: :USD),
      create(:currency, code: :EUR)
    ]
  end

  context "param" do
    it "currency can be only of class Currency" do
      expect(described_class.run(currencies: [double])).to be_invalid
    end
  end

  it "return nil when api is unavailable" do
    stub_request(:get, "https://www.tinkoff.ru/api/v1/currency_rates/")
      .to_return(status: 500, body: "{}")

    run = described_class.run(currencies: currencies, retry_time: 0)
    expect(run).to be_valid
    expect(run.result).to be_nil
  end

  it "updates rates" do
    stub_request(:get, "https://www.tinkoff.ru/api/v1/currency_rates/")
      .to_return(status: 200, body: http_success_body)

    run = described_class.run(currencies: currencies)
    expect(run).to be_valid
    expect(run.result).to eq(CurrencyRate.all)
    expect(run.result.count).to be(2)
  end
end
