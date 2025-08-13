class Character < ApplicationRecord
  belongs_to :user
  has_many :inventory_items

  validates :name, presence: true, length: { minimum:1, maximum:100 }
  validates :class_name, :gender, :apperance, presence: true


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
