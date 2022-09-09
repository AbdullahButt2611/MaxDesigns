class AddTypeToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :project_type, :int
    change_column_default :projects, :project_type, 0
  end
end
