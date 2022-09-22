class AddReferencesToTransactions < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :transactions, :order, index: {algorithm: :concurrently}
    add_reference :transactions, :user, index: {algorithm: :concurrently}
  end
end
