class SetReferenceCheckToOrderDetails < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  
  def change
    validate_check_constraint :order_details, name: "order_details_order_id_null"
    change_column_null :order_details, :order_id, false
    remove_check_constraint :order_details, name: "order_details_order_id_null"

    validate_check_constraint :order_details, name: "order_details_vendor_id_null"
    change_column_null :order_details, :vendor_id, false
    remove_check_constraint :order_details, name: "order_details_vendor_id_null"

    validate_check_constraint :order_details, name: "order_details_item_id_null"
    change_column_null :order_details, :item_id, false
    remove_check_constraint :order_details, name: "order_details_item_id_null"
  end
end
