class Currency < ApplicationRecord
  has_many :from_rates, foreign_key: :from_currency_id,
                        class_name: "CurrencyRate"

  validates :code, uniqueness: true, format: { with: /[A-Z]{3}/ }
end
