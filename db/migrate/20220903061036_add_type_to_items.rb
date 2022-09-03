class AddTypeToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :item_type, :int, default: 0
  end
end
