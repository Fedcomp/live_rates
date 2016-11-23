require "rails_helper"

RSpec.describe CurrencyRate, type: :model do
  it { should validate_presence_of(:buy) }
  it { should validate_presence_of(:sell) }

  it do
    should belong_to(:from_currency)
      .with_foreign_key(:from_currency_id)
      .class_name("Currency")
  end

  it do
    should belong_to(:to_currency)
      .with_foreign_key(:to_currency_id)
      .class_name("Currency")
  end

  describe "factory" do
    it "should be valid" do
      create(:currency_rate)
    end
  end
end
