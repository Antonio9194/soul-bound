class AddRarityToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :rarity, :string
  end
end
