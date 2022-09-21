class AddForeignKeyToAmountReceiveds < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :amount_receiveds, :projects, validate: false
    add_foreign_key :amount_receiveds, :users, validate: false
  end
end
