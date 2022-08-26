class AddRolesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_roles, :int
  end
end
