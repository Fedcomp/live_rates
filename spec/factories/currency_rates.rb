FactoryGirl.define do
  factory :currency_rate do
    association :from_currency, factory: :currency
    association :to_currency,   factory: :currency

    buy { Faker::Commerce.price }
    sell { Faker::Commerce.price }
  end
end
