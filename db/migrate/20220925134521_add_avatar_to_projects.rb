class AddAvatarToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :avatar, :string
  end
end
