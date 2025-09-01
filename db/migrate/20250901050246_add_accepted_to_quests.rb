class AddAcceptedToQuests < ActiveRecord::Migration[7.1]
  def change
     add_column :quests, :accepted, :boolean, default: false, null: false
  end
end
