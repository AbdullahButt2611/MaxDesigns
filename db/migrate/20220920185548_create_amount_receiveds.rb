class CreateAmountReceiveds < ActiveRecord::Migration[6.1]
  def change
    create_table :amount_receiveds do |t|
      t.money :money_received
      t.integer :mode
      t.text :purpose
      t.datetime :date

      t.timestamps
    end
  end
end
