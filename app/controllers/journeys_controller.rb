class JourneysController < ApplicationController
  def new
    @journey = Journey.new
  end

  def create
    @journey = Journey.new(journey_params)
    @journey.user_id = current_user.id

    if @journey.save
      # Build prompt from journey attributes
      prompt = <<~PROMPT
        Based on these answers:
        Purpose: #{@journey.purpose}
        Daily quests: #{@journey.daily_quests}
        Main quest: #{@journey.main_quest}
        For daily quests generate a list of daily quests that will become the 
        user daily routine, as for the main quests based on the deadline and prompt 
        create a serious of quests respecting the dates and tasks, make all of this
        sound rpg style
        PROMPT

      chat = RubyLLM.chat
      response = chat.ask( prompt )

      quests_text = response.content

      quests_text.split("\n").each do |line|
        next if line.strip.empty?
        @journey.quests.create(description: line.strip)
      end

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
