class Journey < ApplicationRecord
  belongs_to :user

  validates :purpose, presence: true
  validate :at_least_one_choice

  def at_least_one_choice
    if daily_quests.blank? && main_quest.blank?
      errors.add(:base, "You must fill in either Daily Quests or Main Quest")
    end
  end
end
