class CreateVendors < ActiveRecord::Migration[6.1]
  def change
    create_table :vendors do |t|
      t.string :company_name
      t.text :address
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
