class InventoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :character

  validates :equipped, inclusion: { in: [true, false] }
end
