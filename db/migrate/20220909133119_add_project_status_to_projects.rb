class AddProjectStatusToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :project_status, :int
    change_column_default :projects, :project_status, 0
  end
end
