class AddCompleteDateToQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :complete_date, :date
  end
end
