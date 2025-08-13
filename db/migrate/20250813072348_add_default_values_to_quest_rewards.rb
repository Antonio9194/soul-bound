class AddDefaultValuesToQuestRewards < ActiveRecord::Migration[7.1]
  def change
    change_column_default :quests, :xp_reward, from: nil, to: 100
    change_column_default :quests, :coin_reward, from: nil, to: 300
  end
end