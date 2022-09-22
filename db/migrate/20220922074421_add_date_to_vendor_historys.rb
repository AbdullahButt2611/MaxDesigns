class AddDateToVendorHistorys < ActiveRecord::Migration[6.1]
  def change
    add_column :vendor_historys, :date, :datetime
  end
end
