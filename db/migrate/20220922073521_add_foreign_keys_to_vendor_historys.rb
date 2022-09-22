class AddForeignKeysToVendorHistorys < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :vendor_historys, :orders, validate: false
    add_foreign_key :vendor_historys, :vendors, validate: false
  end
end
