class Quest < ApplicationRecord
  belongs_to :user
  has_one :quest_item
  has_one :item, through: :quest_item # this is the reward item

  validates :title, presence: true
  validates :description, presence: true
  validates :time, presence: true
  validates :quest_type, presence: true, inclusion: { in: %w[daily main both], message: "%{value} is not a valid quest type" }
  validates :completed, inclusion: { in: [true, false] }
  validates :xp_reward, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :coin_reward, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :deadline, presence: true, if: -> { quest_type == "main" }

  def complete!
    self.completed = true
    save!
  end

  def give_rewards
    user.character.gain_xp(xp_reward)
    user.character.gain_coins(coin_reward)
  end

  def complete_date!
    self.complete_date = Date.today
    save!
  end

  def quest_marked_completed
    return if self.completed
    complete!
    complete_date!
    give_rewards
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
