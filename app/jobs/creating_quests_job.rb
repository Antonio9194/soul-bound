class CreatingQuestsJob < ApplicationJob
  queue_as :default

  def perform(journey)
    prompt = <<~PROMPT
You are the god of the realm, crafting epic quests in a magical RPG world.


Based on the user's choice ("daily", "main", or "both"), do the following:

- If the choice is "daily":
  - Generate ONLY daily quests. Do NOT generate main quests.
  - Create 6 daily quests, only 6 quests,no more than 6, not less than 6.
  - Each daily quest must have:
    - a "title" with NO labels such as "daily" or "main" included.
    - a "description" written in vivid RPG/fantasy style: it should feel like a magical quest, adventure, or heroic challenge, but must clearly reflect the real-life task the user needs to complete, so the user can understand what action to take.
    - Always assign a realistic time or time range based on the task description.
- Use context words to infer the time:
  - Breakfast → 7:00–9:00
  - Lunch → 12:00–13:00
  - Dinner → 18:00–20:00
  - Morning → 6:00–12:00
  - Afternoon → 13:00–16:00
  - Evening → 17:00–21:00
- If no context exists, assign a reasonable default 2–3 hour window based on common daily logic.
      - a **specific "time" or "time range"** that you MUST assign even if the user does NOT explicitly mention it.
      Use common sense and daily logic to infer fixed times or windows.
    - NEVER omit the "time" field.
      Even if the user does not explicitly provide times, assign logical fixed times or windows based on common sense.
  - Do NOT include any deadlines for daily quests.
  - Keep all text no longer than 3 lines!

- If the choice is "main":
  - Generate ONLY the main quest as a narrative with tasks, each having titles and deadlines.
  - Do NOT generate daily quests.

- If the choice is "both":
  - Generate both daily quests and main quest as above.

Always ensure that:
- Titles never include the words "daily" or "main" or similar labels.
- All quests feel like magical, vivid RPG adventures that relate clearly to the user's real-life tasks.
- Output ONLY the quests relevant to the user’s choice in JSON format as specified, with no extra text or explanations.

The user's choice is "#{journey.purpose}".
The user's daily quest input is "#{journey.daily_quests}".
The user's main goal input is "#{journey.main_quest}".

Output format:
{
  "daily_quests": [
    {"title": "title 1", "time": "quest.time", "description": "description"},
    {"title": "title 2", "time": "quest.time", "description": "description"},
    ...
  ],
  "main_quest": {
    "title": "Main Quest Title",
    "description": "Story narrative linking all tasks",
    "deadline": "optional deadline",
    "tasks": [
      {"title": "Task 1", "description": "desc", "deadline": "deadline"},
      ...
    ]
  }
}

If daily quests are not requested, omit "daily_quests".
If main quests are not requested, omit "main_quest".
PROMPT
      
      chat = RubyLLM.chat(assume_model_exists: true, provider: :openai)
      # chat = RubyLLM.chat
      response = chat.ask(prompt)

      quests_text = response.content
      puts quests_text

      parsed_quests = JSON.parse(quests_text)

      # Create daily quests if present
      if parsed_quests["daily_quests"]
        parsed_quests["daily_quests"].each do |quest|

          new_quest = journey.user.quests.new(
            title: quest["title"],
            description: quest["description"],
            time: quest["time"],
            quest_type: "daily",
            completed: false,
            xp_reward: 100,
            coin_reward: 300,
          )
          new_quest.save!
        end
      end

      # Create main quests if present
      if parsed_quests["main_quest"] && parsed_quests["main_quest"]["tasks"]
        parsed_quests["main_quest"]["tasks"].each do |task|
          journey.user.quests.create(
            title: task["title"],
            description: task["description"],
            quest_type: "main",
            completed: false,
            xp_reward: 300,
            coin_reward: 700,
            deadline: task["deadline"]
          )
        end
      end
  end


end
