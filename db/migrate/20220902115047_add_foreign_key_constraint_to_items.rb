class AddForeignKeyConstraintToItems < ActiveRecord::Migration[6.1]
  def change
    validate_foreign_key :items, :vendors
  end
end
