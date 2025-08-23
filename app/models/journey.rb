class Journey < ApplicationRecord
  belongs_to :user

  validates :purpose, presence: true
  validate :at_least_one_choice
  after_create_commit :create_quests

  def at_least_one_choice
    if daily_quests.blank? && main_quest.blank?
      errors.add(:base, "You must fill in either Daily Quests or Main Quest")
    end
  end

  private

  def create_quests
    prompt = <<~PROMPT
You are the god of the realm, crafting epic quests in a magical RPG world.


Based on the user's choice ("daily", "main", or "both"), do the following:

- If the choice is "daily":
  - Generate ONLY daily quests. Do NOT generate main quests.
  - Create at least 6 daily quests (or more if appropriate).
  - Each daily quest must have:
    - a "title" with NO labels such as "daily" or "main" included.
    - a vivid "description" that inspires the user.
      - a **specific "time" or "time range"** that you MUST assign even if the user does NOT explicitly mention it.
      Use common sense and daily logic to infer fixed times or windows.
    - NEVER omit the "time" field.
      Even if the user does not explicitly provide times, assign logical fixed times or windows based on common sense.
  - Do NOT include any deadlines for daily quests.

- If the choice is "main":
  - Generate ONLY the main quest as a narrative with tasks, each having titles and deadlines.
  - Do NOT generate daily quests.

- If the choice is "both":
  - Generate both daily quests and main quest as above.

Always ensure that:
- Titles never include the words "daily" or "main" or similar labels.
- All quests feel like magical, vivid RPG adventures that relate clearly to the user's real-life tasks.
- Output ONLY the quests relevant to the user’s choice in JSON format as specified, with no extra text or explanations.

The user's choice is "#{purpose}".
The user's daily quest input is "#{daily_quests}".
The user's main goal input is "#{main_quest}".

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

      chat = RubyLLM.chat
      response = chat.ask(prompt)

      quests_text = response.content
      puts quests_text

      parsed_quests = JSON.parse(quests_text)

      # Create daily quests if present
      if parsed_quests["daily_quests"]
        parsed_quests["daily_quests"].each do |quest|
          user.quests.create(
            title: quest["title"],
            description: quest["description"],
            time: quest["time"],
            quest_type: "daily",
            completed: false,
            xp_reward: 100,
            coin_reward: 300
          )
        end
      end

      # Create main quests if present
      if parsed_quests["main_quest"] && parsed_quests["main_quest"]["tasks"]
        parsed_quests["main_quest"]["tasks"].each do |task|
          user.quests.create(
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
