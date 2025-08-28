class SetDefaultSlotsForCharacters < ActiveRecord::Migration[7.1]
  def change
    change_column_default :characters, :slots, from: nil, to: 10
  end
end
