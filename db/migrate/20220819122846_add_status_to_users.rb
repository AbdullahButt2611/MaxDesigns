class AddStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :activity_status, :integer, default: 0
  end
end
