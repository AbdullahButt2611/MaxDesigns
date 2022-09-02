class SetForeignKeyNullToFalseInItemsStrongly < ActiveRecord::Migration[6.1]
  def change
    validate_check_constraint :items, name: "items_vendor_id_null"
    change_column_null :items, :vendor_id, false
    remove_check_constraint :items, name: "items_vendor_id_null"
  end
end
