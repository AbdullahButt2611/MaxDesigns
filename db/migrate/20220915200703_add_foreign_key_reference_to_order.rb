class AddForeignKeyReferenceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :orders, :projects, validate: false
  end
end
