class QuestsController < ApplicationController
  def dashboard
    @quests = current_user.quests
  end
end