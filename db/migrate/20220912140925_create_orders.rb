class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :order_type
      t.datetime :order_date

      t.timestamps
    end
  end
end
