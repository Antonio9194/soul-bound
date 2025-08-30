class QuestsController < ApplicationController
  def dashboard
    @daily_quests = current_user.quests.where(quest_type: 'daily').order(time: :asc)
    @daily_quests.each do |quest|
      next unless quest.complete_date
        if quest.complete_date < Date.today
          quest.item_reward = quest.reward_roll
          quest.completed = false
          quest.save!
        end
    end
  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    @quest = Quest.find(params[:id])
    was_incomplete = !@quest.completed?

    # if @quest.update(quest_params)
      if was_incomplete
        @quest.quest_marked_completed(current_user.character)
        @reward_id = @quest.item_reward
        @item_reward = Item.find_by(id: @reward_id)
        if @item_reward
          current_user.character.inventory_items.create!(item: @item_reward, equipped: false)
        end
        @quest.mark_recently_completed!
        # @quest.set_reward_item(@reward)
      end
      # redirect_to dashboard_quests_path unless quest_params[:completed]
    # else
    #   flash[:alert] = "Failed to complete the quest."
    #   render :edit, status: :unprocessable_entity
    # end
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :time, :xp_reward, :coin_reward)
  end
end

