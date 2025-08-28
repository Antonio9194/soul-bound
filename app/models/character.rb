class Character < ApplicationRecord
  belongs_to :user
  has_many :inventory_items
  has_many :items, through: :inventory_items
  has_many :quests

  validates :name, presence: true, length: { minimum:1, maximum:100 }
  validates :class_name, presence: true
  validates :gender, presence: true, unless: -> { class_name&.downcase == "gorgon" }

  def image_path
    return "default.png" if gender.blank? || class_name.blank?
    "#{gender.downcase}_#{class_name.downcase}.png"
  end

  def purchase_slot
    slot_price = 5000
    if self.coin >= slot_price
      self.coin -= slot_price
      self.slots += 1
      save!
      true
    else
      false
    end
  end

  def sell_slot
    slot_price = 5000
    return unless self.slots > 0
    self.slots -= 1
    sell_slot_price = slot_price / 2
    self.coin += sell_slot_price
    save!
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
