class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :quest_type
      t.boolean :completed
      t.date :deadline
      t.integer :xp_reward
      t.integer :coin_reward

      t.timestamps
    end
  end
end
