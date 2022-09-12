class CreateProjectDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :project_details do |t|
      t.datetime :date
      t.string :task

      t.timestamps
    end
  end
end
