class SetReferenceCheckToAmountReceiveds < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    validate_check_constraint :amount_receiveds, name: "amount_receiveds_project_id_null"
    change_column_null :amount_receiveds, :project_id, false
    remove_check_constraint :amount_receiveds, name: "amount_receiveds_project_id_null"

    validate_check_constraint :amount_receiveds, name: "amount_receiveds_user_id_null"
    change_column_null :amount_receiveds, :user_id, false
    remove_check_constraint :amount_receiveds, name: "amount_receiveds_user_id_null"
  end
end
