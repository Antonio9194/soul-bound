class Quest < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :time, presence: true
  validates :quest_type, presence: true, inclusion: { in: %w[daily main both], message: "%{value} is not a valid quest type" }
  validates :completed, inclusion: { in: [true, false] }
  validates :xp_reward, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :coin_reward, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :deadline, presence: true, if: -> { quest_type == "main" }
end



