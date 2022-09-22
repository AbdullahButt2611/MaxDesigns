class AddSetReferneceToTransactions < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    validate_check_constraint :transactions, name: "transactions_order_id_null"
    change_column_null :transactions, :order_id, false
    remove_check_constraint :transactions, name: "transactions_order_id_null"

    validate_check_constraint :transactions, name: "transactions_user_id_null"
    change_column_null :transactions, :user_id, false
    remove_check_constraint :transactions, name: "transactions_user_id_null"
  end
end
