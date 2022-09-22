class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.money :amount_paid
      t.datetime :date

      t.timestamps
    end
  end
end
