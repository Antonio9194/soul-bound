class QuestsController < ApplicationController
  def dashboard
    @quests = current_user.quests
  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    @quest = Quest.find(params[:id])
    if @quest.update(quest_params)
      redirect_to dashboard_quests_path, notice: "Quest updated!"
    else 
      render :edit, status: :unprocessable_entity
    end  
  end

  private

  def quest_params
    params.require(:quest).permit(:title, :description, :completed, :time)
  end
end