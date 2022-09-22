class AddForeignKeysToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :transactions, :orders, validate: false
    add_foreign_key :transactions, :users, validate: false
  end
end
