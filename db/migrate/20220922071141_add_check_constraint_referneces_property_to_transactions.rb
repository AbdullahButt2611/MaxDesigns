class AddCheckConstraintRefernecesPropertyToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :transactions, "order_id IS NOT NULL", name: "transactions_order_id_null", validate: false
  end
end
