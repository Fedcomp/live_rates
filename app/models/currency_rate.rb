class CurrencyRate < ApplicationRecord
  belongs_to :from_currency, foreign_key: :from_currency_id,
                             class_name: "Currency"

  belongs_to :to_currency, foreign_key: :to_currency_id,
                           class_name: "Currency"

  validates :buy, :sell, presence: true
end
