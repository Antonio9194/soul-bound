class AddDefaultToInventoryItems < ActiveRecord::Migration[7.1]
  def change
    change_column :inventory_items, :equipped, :boolean, default: false, null: false

  end
end
