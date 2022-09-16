class AddReferencesToOrderDetails < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :order_details, :order, index: {algorithm: :concurrently}
    add_reference :order_details, :vendor, index: {algorithm: :concurrently}
    add_reference :order_details, :item, index: {algorithm: :concurrently}
  end
end
