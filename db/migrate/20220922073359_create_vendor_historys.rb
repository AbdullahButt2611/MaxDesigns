class CreateVendorHistorys < ActiveRecord::Migration[6.1]
  def change
    create_table :vendor_historys do |t|
      t.money :amount

      t.timestamps
    end
  end
end
