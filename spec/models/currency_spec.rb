require "rails_helper"

RSpec.describe Currency, type: :model do
  it { should validate_uniqueness_of(:code) }

  it { should allow_value("USD", "EUR").for(:code) }
  it { should_not allow_value("US", "U", nil).for(:code) }
end
