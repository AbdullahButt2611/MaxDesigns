class AddReferencesToAmountReceiveds < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :amount_receiveds, :project, index: {algorithm: :concurrently}
    add_reference :amount_receiveds, :user, index: {algorithm: :concurrently}
  end
end
