class AddAmountPresentInProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :amount_present, :money
  end
end
