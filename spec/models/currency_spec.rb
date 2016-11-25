require "rails_helper"

RSpec.describe Currency, type: :model do
  it { should validate_uniqueness_of(:code) }

  it { should allow_value("USD", "EUR").for(:code) }
  it { should_not allow_value("US", "U", nil).for(:code) }

  it do
    should have_many(:from_rates)
      .class_name("CurrencyRate")
      .with_foreign_key(:from_currency_id)
  end

  describe ".average_rate_against", cache: :clear, time: :freeze do
    let(:custom_intervals) do
      { custom_interval: 2.weeks }
    end

    before do
      expect(Rails.application.config).to receive(:currency_rate_intervals)
        .at_least(:once)
        .and_return(custom_intervals)
    end

    let(:from_currency) { create(:currency) }
    let(:to_currency)   { create(:currency) }

    # Should never be caught
    let!(:old_rate) do
      create :currency_rate,
             from_currency: from_currency,
             to_currency: to_currency,
             buy: 1000.0, # noticeable in calculations
             sell: 1000.0,
             created_at: 2.weeks.ago - 1.second
    end

    context "when data available" do
      let!(:currency_rates_within_interval) do
        [
          [0.1, 0.01],
          [0.2, 0.011],
          [0.2, 0.011],
          [0.4, 0.02],
          [0.4, 0.02],
          [0.4, 0.02]
        ].map do |buy, sell|
          create :currency_rate,
                 from_currency: from_currency,
                 to_currency: to_currency,
                 buy: buy,
                 sell: sell,
                 created_at: rand(0..2.weeks.to_i).seconds.ago
        end
      end

      let!(:rate_on_the_edge) do
        create :currency_rate,
               from_currency: from_currency,
               to_currency: to_currency,
               buy: 100.0, # statistically noticeable
               sell: 100.0,
               created_at: 2.weeks.seconds.ago
      end

      let(:expected_average_rates) do
        { buy: 14.5285714286, sell: 14.2988571429 }
      end

      it "should calculate average buy/sell hash on :custom_interval" do
        result = from_currency
                 .average_rate_against(to_currency, interval: :custom_interval)

        expect(result).to eq(expected_average_rates)
      end

      it "should cache results for 1 minute" do
        call = lambda do
          from_currency
            .average_rate_against(to_currency, interval: :custom_interval)
        end

        expect(call).to make_database_queries(count: 1)
        expect(call).to_not make_database_queries
        Timecop.travel 1.minute.from_now
        expect(call).to make_database_queries(count: 1)
      end
    end

    context "when no data available" do
      it "should return buy/sell hash with nil values" do
        result = from_currency
                 .average_rate_against(to_currency, interval: :custom_interval)

        expect(result).to eq(buy: nil, sell: nil)
      end
    end

  end

  describe "factory" do
    it "should be valid" do
      create :currency
    end
  end
end
