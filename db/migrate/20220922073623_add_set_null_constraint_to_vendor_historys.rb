class AddSetNullConstraintToVendorHistorys < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :vendor_historys, "order_id IS NOT NULL", name: "vendor_historys_order_id_null", validate: false
    add_check_constraint :vendor_historys, "vendor_id IS NOT NULL", name: "vendor_historys_vendor_id_null", validate: false
  end
end
