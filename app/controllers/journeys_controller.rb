class JourneysController < ApplicationController
  def new
    @journey = Journey.new
  end

  def create
    @journey = Journey.new(journey_params)
    @journey.user_id = current_user.id
    if @journey.save
      redirect_to root_path
    else
      flash.now[:alert] = "Oops, something went wrong. Please check your answers."
      render :new
    end
  end

  private

  def journey_params
    params.require(:journey).permit(:purpose, :daily_quests, :main_quest)
  end
end
