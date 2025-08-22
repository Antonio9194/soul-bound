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

The user's choice is "#{@journey.purpose}".
The user's daily quest input is "#{@journey.daily_quests}".
The user's main goal input is "#{@journey.main_quest}".

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

      begin
        chat = RubyLLM.chat
        response = chat.ask(prompt)
        quests_text = response.content.to_s
        puts "Raw LLM response:"
        puts quests_text

        # Extract JSON safely
        json_start = quests_text.index("{")
        json_end = quests_text.rindex("}")
        raise "No JSON found in response" unless json_start && json_end
        parsed_quests = JSON.parse(quests_text[json_start..json_end])

        # Create daily quests if present
        if parsed_quests["daily_quests"]
          parsed_quests["daily_quests"].each do |quest|
            current_user.quests.create(
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
            current_user.quests.create(
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
      rescue RubyLLM::RateLimitError => e
        Rails.logger.warn "LLM rate limit exceeded: #{e.message}"
        flash[:alert] = "The AI service is busy. Your journey was saved, but quests could not be generated. Try again shortly."
      rescue => e
        Rails.logger.error "Error generating quests: #{e.message}"
        flash[:alert] = "An error occurred while generating quests. Your journey was saved."
      end

      # Always redirect after saving the journey
      redirect_to new_character_path
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