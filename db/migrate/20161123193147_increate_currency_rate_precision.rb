class IncreateCurrencyRatePrecision < ActiveRecord::Migration[5.0]
  def change
    change_column :currency_rates, :buy,  :decimal, precision: 15, scale: 10
    change_column :currency_rates, :sell, :decimal, precision: 15, scale: 10
  end
end
