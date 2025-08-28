class AddItemRewardToQuests < ActiveRecord::Migration[7.1]
  def change
    add_column :quests, :item_reward, :integer
  end
end
