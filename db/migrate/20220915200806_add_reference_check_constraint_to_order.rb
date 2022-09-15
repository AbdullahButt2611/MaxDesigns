class AddReferenceCheckConstraintToOrder < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :orders, "project_id IS NOT NULL", name: "orders_project_id_null", validate: false
  end
end
