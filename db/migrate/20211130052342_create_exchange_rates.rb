class CreateExchangeRates < ActiveRecord::Migration[6.0]
  def change
    create_table :exchange_rates do |t|
      t.string :currency_code
      t.float :rate

      t.timestamps
    end
  end
end
