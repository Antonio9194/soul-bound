class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :class_name
      t.string :gender
      t.integer :xp
      t.integer :coin

      t.timestamps
    end
  end
end
