class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :contact, :string
    add_column :users, :qualification, :string
    add_column :users, :pay, :int
  end
end
