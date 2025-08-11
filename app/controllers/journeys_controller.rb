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

  - If "daily", generate exactly 6 daily quests with a "title" and "description". Do NOT include deadlines but add time if the user asks.
  - If "main", generate 1 main quest consisting of multiple tasks. Each task must have:
    - a "title"
    - a vivid "description"
    - a real and specific "deadline" date that exactly matches the user's date.
      If multiple tasks add the deadlines if specified.
  - If "both", generate both the 6 daily quests and the main quest as described.
  Remember that all this must be in RPG style so for daily make it sounds like they are magical quests but still make it so that its related to what the user asked and the task is clear in real life like this: 
  Create a list of daily quests that turn normal routine tasks into exciting fantasy adventures. Each quest should have:
	•	A heroic title (e.g., ‘Slay the Goblin of the Eastern Forest’)
	•	A clear objective that feels like a mission (e.g., ‘Find the lost treasure hidden beneath the ancient oak’)
	•	A time or deadline if relevant
	•	A brief flavorful description that inspires the user to complete the task as if on an epic quest
Avoid generic or mundane instructions. Make every quest feel magical, adventurous, and rewarding, transforming daily habits into immersive role-playing experiences.”


  The user's choice is "#{@journey.purpose}".
  The user's daily quest input is "#{@journey.daily_quests}".
  The user's main goal input is "#{@journey.main_quest}".
  

  Output ONLY the quests relevant to the user's choice in the JSON format below, with no extra text:

  {
    "daily_quests": [
      {"title": "title 1", "description": "description", "time": "time"(if needed)},
      {"title": "title 2", "description": "description", "time": "time"(if needed)},
      {"title": "title 3", "description": "description", "time": "time"(if needed)},
      {"title": "title 4", "description": "description", "time": "time"(if needed)},
      {"title": "title 5", "description": "description", "time": "time"(if needed)},
      {"title": "title 6", "description": "description", "time": "time"(if needed)}
    ],
    "main_quest": {
    "title": "Main Quest Title",
    "description": "Remember to create a story narrative style rpg connected trhough all the tasks until the last deadline goal",
    "deadline": "optional main quest deadline if specified",
    "tasks": [
      {
        "title": "Task 1 title",
        "description": "Optional task 1 description",
        "deadline": "optional task 1 deadline"
      },
      {
        "title": "Task 2 title",
        "description": "Optional task 2 description",
        "deadline": "optional task 2 deadline"
      }
      // ...more tasks if specified
    ]
  }
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
