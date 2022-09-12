class SettingNullPropertyForProjectDetailsToFalse < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  def change
    validate_check_constraint :project_details, name: "project_details_user_id_null"
    change_column_null :project_details, :user_id, false
    remove_check_constraint :project_details, name: "project_details_user_id_null"

    validate_check_constraint :project_details, name: "project_details_project_id_null"
    change_column_null :project_details, :project_id, false
    remove_check_constraint :project_details, name: "project_details_project_id_null"
  end
end
