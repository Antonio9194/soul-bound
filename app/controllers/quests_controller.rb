class QuestsController < ApplicationController
  def dashboard
    @quests = current_user.quests
  end

  def edit
    @quest = Quest.find(params[:id])
  end

end