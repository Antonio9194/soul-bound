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
    if @quest.update(quest_params)
      redirect_to dashboard_quests_path
    else
      redirect_to dashboard_quests_path, flash[:alert] = "Failed to save!"
    end
  end

  def complete
    @quest = Quest.find(params[:id])
    if @quest.quest_marked_completed
      flash[:notice] = "Quest completed!"
      redirect_to dashboard_quests_path
    else
      flash[:alert] = "Failed to complete the quest!"
      redirect_to dashboard_quests_path
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:time)
  end
end

