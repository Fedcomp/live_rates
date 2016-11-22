class Currency < ApplicationRecord
  validates :code, uniqueness: true, format: { with: /[A-Z]{3}/ }
end
