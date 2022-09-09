class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :client_name
      t.string :contact
      t.text :location
      t.money :amount_promised
      t.datetime :deadline

      t.timestamps
    end
  end
end
