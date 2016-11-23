class AddSymbolToCurrency < ActiveRecord::Migration[5.0]
  def change
    add_column :currencies, :symbol, :string
  end
end
