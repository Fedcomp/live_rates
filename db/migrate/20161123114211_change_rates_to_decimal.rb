class ChangeRatesToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :currency_rates, :buy,  :decimal, precision: 8, scale: 2
    change_column :currency_rates, :sell, :decimal, precision: 8, scale: 2
  end
end
