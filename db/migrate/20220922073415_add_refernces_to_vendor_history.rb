class AddReferncesToVendorHistory < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :vendor_historys, :order, index: {algorithm: :concurrently}
    add_reference :vendor_historys, :vendor, index: {algorithm: :concurrently}
  end
end
