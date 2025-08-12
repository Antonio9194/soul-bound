class AddTimeToQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :time, :time
  end
end
