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

  describe "factory" do
    it "should be valid" do
      create :currency
    end
  end
end
