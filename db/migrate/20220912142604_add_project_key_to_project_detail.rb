class AddProjectKeyToProjectDetail < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :project_details, :projects, validate: false
    add_foreign_key :project_details, :orders, validate: false
    add_foreign_key :project_details, :users, validate: false
  end
end
