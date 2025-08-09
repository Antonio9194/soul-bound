class AddApperanceToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :apperance, :string
  end
end
