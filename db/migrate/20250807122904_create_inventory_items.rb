class CreateInventoryItems < ActiveRecord::Migration[7.1]
  def change
    create_table :inventory_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true
      t.boolean :equipped

      t.timestamps
    end
  end
end
