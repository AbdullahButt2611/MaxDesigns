class SetForeignKeyNullToFalseInItems < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :items, "vendor_id IS NOT NULL", name: "items_vendor_id_null", validate: false
  end
end
