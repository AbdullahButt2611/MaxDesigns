class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :contactNumber
      t.string :company
      t.text :message

      t.timestamps
    end
  end
end
