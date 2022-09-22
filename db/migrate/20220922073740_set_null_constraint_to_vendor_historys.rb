class SetNullConstraintToVendorHistorys < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    validate_check_constraint :vendor_historys, name: "vendor_historys_order_id_null"
    change_column_null :vendor_historys, :order_id, false
    remove_check_constraint :vendor_historys, name: "vendor_historys_order_id_null"

    validate_check_constraint :vendor_historys, name: "vendor_historys_vendor_id_null"
    change_column_null :vendor_historys, :vendor_id, false
    remove_check_constraint :vendor_historys, name: "vendor_historys_vendor_id_null"
  end
end
