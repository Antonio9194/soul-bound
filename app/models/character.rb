class Character < ApplicationRecord
  belongs_to :user
  has_many :inventory_items
  has_many :items, through: :inventory_items
  has_many :quests

  validates :name, presence: true, length: { minimum:1, maximum:100 }
  validates :class_name, presence: true
  validates :gender, presence: true, unless: -> { class_name&.downcase == "gorgon" }

  def inventory_limit
    if inventory_items.size > slots
      errors.add(:inventory_items, "cannot have more than #{slots} items")
    end
  end

  def image_path
    return "default.png" if gender.blank? || class_name.blank?
    "#{gender.downcase}_#{class_name.downcase}.png"
  end


  def xp_to_next_level
    (100 * (self.level + 1)**1.5).to_i 
  end

  def gain_xp(amount)
    self.xp += amount
    while self.xp >= xp_to_next_level
      self.xp -= xp_to_next_level
      self.level += 1
    end
    save!
  end

  def gain_coins(amount)
    self.coin += amount
    save!
  end

end
