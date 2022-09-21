class AddCheckConstraintOnProjectDetails < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :project_details, "user_id IS NOT NULL", name: "project_details_user_id_null", validate: false
    add_check_constraint :project_details, "project_id IS NOT NULL", name: "project_details_project_id_null", validate: false
  end
end
