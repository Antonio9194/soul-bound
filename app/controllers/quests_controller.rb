class QuestsController < ApplicationController
  def dashboard
    @daily_quests = current_user.quests.where(quest_type: 'daily').order(time: :asc)

  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    @quest = Quest.find(params[:id])
    was_incomplete = !@quest.completed?

    if @quest.update(quest_params)
      if was_incomplete && @quest.completed?
        @quest.quest_marked_completed(current_user.character)
        @rarity = reward_rarity
        @items = Item.where(rarity: @rarity)
        @random = rand(@items.length)
        @reward = @items[@random]
        @last_reward = current_user.character.inventory_items.create!(item: @reward, equipped: false)
        @quest.mark_recently_completed!
        @quest.set_reward_item(@reward)
      end
      redirect_to dashboard_quests_path unless quest_params[:completed]
    else
      flash[:alert] = "Failed to complete the quest."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def reward_rarity
    roll = rand(1000)
    case
    when roll < 1
      return nil
    when roll >= 1 && roll < 777
      return "Common"
    when roll >= 777 && roll < 888
      return "Uncommon"
    when roll >= 888 && roll < 950
      return "Rare"
    when roll >= 950 && roll < 995
      return "Epic"
    when roll >= 995
      return "Legendary"
    end
  end

  def quest_params
    params.require(:quest).permit(:title, :description, :completed, :time, :xp_reward, :coin_reward)
  end
end
