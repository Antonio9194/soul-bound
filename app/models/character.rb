class Character < ApplicationRecord
  belongs_to :user
  has_many :inventory_items, dependent: :destroy
  has_many :items, through: :inventory_items
  has_many :quests

  validates :name, presence: true, length: { minimum:1, maximum:100 }
  validates :class_name, presence: true
  validates :gender, presence: true

  def image_path
    return "default.png" if gender.blank? || class_name.blank?
    "#{gender.downcase}_#{class_name.downcase}.png"
  end

  def purchase_slot
    if slot <= 10
     slot_price = 5000
    else
      slot_price = slot * slot * 100
    end 
    return false if self.coin < slot_price 
    if self.coin >= slot_price
      self.coin -= slot_price
      self.slots += 1
      save
    end
  end

  def sell_slot
    slot_price = 5000
    return false if self.slots <= 1
    self.slots -= 1
    sell_slot_price = slot_price / 2
    self.coin += sell_slot_price
    save
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

  def triple_xp
    xp_reward * 4
  end

  def triple_coin
    coin_reward * 4
  end

  def gain_coins(amount)
    self.coin += amount
    save!
  end

end
