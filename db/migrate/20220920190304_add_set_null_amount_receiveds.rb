class AddSetNullAmountReceiveds < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :amount_receiveds, "project_id IS NOT NULL", name: "amount_receiveds_project_id_null", validate: false
    add_check_constraint :amount_receiveds, "user_id IS NOT NULL", name: "amount_receiveds_user_id_null", validate: false
  end
end
