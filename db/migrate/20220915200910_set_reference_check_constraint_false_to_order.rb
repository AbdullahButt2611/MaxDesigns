class SetReferenceCheckConstraintFalseToOrder < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  
  def change
    validate_check_constraint :orders, name: "orders_project_id_null"
    change_column_null :orders, :project_id, false
    remove_check_constraint :orders, name: "orders_project_id_null"
  end
end
