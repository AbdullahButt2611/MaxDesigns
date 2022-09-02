class AddForeignKeyToItems < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :items, :vendors, validate: false
  end
end
