class JourneysController < ApplicationController
  def new
    @journey = Journey.new
  end

    def create
    @journey = Journey.new(journey_params)
    @journey.user_id = current_user.id

    if @journey.save
      prompt = <<~PROMPT
  You are the god of the realm, crafting epic quests in a magical RPG world.

  Based on the user's choice: "daily", "main", or "both", create quests as follows:

  - If "daily", generate exactly 6 daily quests with a "title" and "description". Do NOT include deadlines.
  - If "main", generate 1 main quest consisting of multiple tasks. Each task must have:
    - a "title"
    - a vivid "description"
    - a real and specific "deadline" date that exactly matches the user's input deadline (in YYYY-MM-DD format).
      If multiple tasks, all deadlines should be exactly the same user deadline.
      You may create deadlines for intermediate steps if needed, but never exceed the user deadline.
  - If "both", generate both the 6 daily quests and the main quest as described.

  The user's choice is "#{@journey.purpose}".
  The user's daily quest input is "#{@journey.daily_quests}".
  The user's main goal input is "#{@journey.main_quest}".
  

  Output ONLY the quests relevant to the user's choice in the JSON format below, with no extra text:

  {
    "daily_quests": [
      {"title": "title 1", "description": "description"},
      {"title": "title 2", "description": "description"},
      {"title": "title 3", "description": "description"},
      {"title": "title 4", "description": "description"},
      {"title": "title 5", "description": "description"},
      {"title": "title 6", "description": "description"}
    ],
    "main_quest": {
      "tasks": [
        {"title": "Main task 1", "description": "description", "deadline": "deadline"},
        {"title": "Main task 2", "description": "description", "deadline": "deadline"}
      ],
      "deadline": "deadline"
    }
  }

  If daily quests are not needed, omit "daily_quests". If main quest is not needed, omit "main_quest".

  Remember, every quest should feel like a magical adventure, vivid and inspiring.
PROMPT

      chat = RubyLLM.chat
      response = chat.ask(prompt)

      quests_text = response.content
      puts quests_text

      parsed_quests = JSON.parse(quests_text)

      # Create daily quests if present
      if parsed_quests["daily_quests"]
        parsed_quests["daily_quests"].each do |quest|
          current_user.quests.create(
            title: quest["title"],
            description: quest["description"],
            quest_type: "daily",
            completed: false,
            xp_reward: 5,
            coin_reward: 5
          )
        end
      end

      # Create main quests if present
      if parsed_quests["main_quest"] && parsed_quests["main_quest"]["tasks"]
        parsed_quests["main_quest"]["tasks"].each do |task|
          current_user.quests.create(
            title: task["title"],
            description: task["description"],
            quest_type: "main",
            completed: false,
            xp_reward: 10,
            coin_reward: 10,
            deadline: task["deadline"]
          )
        end
      end

      redirect_to dashboard_quests_path
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
