class AddForeignKeyToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :order_details, :orders, validate: false
    add_foreign_key :order_details, :vendors, validate: false
    add_foreign_key :order_details, :items, validate: false
  end
end
