class AddPriceToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :price, :integer
  end
end
