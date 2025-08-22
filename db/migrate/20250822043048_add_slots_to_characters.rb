class AddSlotsToCharacters < ActiveRecord::Migration[7.1]
  def change
    add_column :characters, :slots, :integer
  end
end
