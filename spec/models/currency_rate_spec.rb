require "rails_helper"

RSpec.describe CurrencyRate, type: :model do
  it { should validate_presence_of(:buy) }
  it { should validate_presence_of(:sell) }
end
