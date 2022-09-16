class AddSetNullToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :order_details, "order_id IS NOT NULL", name: "order_details_order_id_null", validate: false
    add_check_constraint :order_details, "vendor_id IS NOT NULL", name: "order_details_vendor_id_null", validate: false
    add_check_constraint :order_details, "item_id IS NOT NULL", name: "order_details_item_id_null", validate: false
  end
end
