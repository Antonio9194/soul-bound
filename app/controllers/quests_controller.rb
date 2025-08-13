class QuestsController < ApplicationController
  def dashboard
    @quests = current_user.quests
  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    @quest = Quest.find(params[:id])
    was_incomplete = !@quest.completed?
    if @quest.update(quest_params)
      if was_incomplete && @quest.completed?
        @quest.give_rewards(current_user.character)
      end
      redirect_to dashboard_quests_path, notice: "Quest updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :completed, :time, :xp_reward, :coin_reward)
  end
end