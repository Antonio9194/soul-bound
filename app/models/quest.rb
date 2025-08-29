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

  def complete!(character)
    self.completed = true
    save!
  end

  def give_rewards(character)
    character.gain_xp(self.xp_reward)
    character.gain_coins(self.coin_reward)
  end

  def complete_date!(character)
    self.complete_date = Date.today
    save!
  end

  def quest_marked_completed(character)
    return if self.completed
    complete!(character)
    complete_date!(character)
    give_rewards(character)
  end


  def recently_completed?
    @recently_completed ||= false
  end

  def mark_recently_completed!
    @recently_completed = true
  end

  def reward_item
    @reward_item
  end

  def set_reward_item(item)
    @reward_item = item
  end

  def reward_roll
    item_id = nil
    rarity = nil
    roll = rand(1000)
    case
    when roll < 1
      rarity = nil
    when roll >= 1 && roll < 777
      rarity = "Common"
    when roll >= 777 && roll < 888
      rarity = "Uncommon"
    when roll >= 888 && roll < 950
      rarity = "Rare"
    when roll >= 950 && roll < 995
      rarity = "Epic"
    when roll >= 995
      rarity = "Legendary"
    end
    if rarity
      items = Item.where(rarity: rarity)
      item_id = items[rand(items.length)].id
    end
    return item_id
  end
end
