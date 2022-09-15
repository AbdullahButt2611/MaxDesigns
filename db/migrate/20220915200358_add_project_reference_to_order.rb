class AddProjectReferenceToOrder < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :orders, :project, index: {algorithm: :concurrently}
  end
  
end
