class AddProjectReferenceToProjectDetail < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :project_details, :project, index: {algorithm: :concurrently}
    add_reference :project_details, :order, index: {algorithm: :concurrently}
    add_reference :project_details, :user, index: {algorithm: :concurrently}
  end
end
