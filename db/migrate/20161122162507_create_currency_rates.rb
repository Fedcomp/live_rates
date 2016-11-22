class CreateCurrencyRates < ActiveRecord::Migration[5.0]
  def change
    create_table :currency_rates do |t|
      t.integer :from_currency_id
      t.integer :to_currency_id
      t.integer :buy
      t.integer :sell

      t.timestamps
    end

    add_index :currency_rates, :from_currency_id
    add_foreign_key :currency_rates, :currencies,
                    column: :from_currency_id, primary_key: :id

    add_index :currency_rates, :to_currency_id
    add_foreign_key :currency_rates, :currencies,
                    column: :to_currency_id,   primary_key: :id
  end
end
