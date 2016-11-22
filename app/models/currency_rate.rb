class CurrencyRate < ApplicationRecord
  validates :buy, :sell, required: true
end
