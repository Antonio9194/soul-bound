class AddImgToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :img, :string
  end
end
