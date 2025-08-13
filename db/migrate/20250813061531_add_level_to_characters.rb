class AddLevelToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :level, :integer
  end
end
