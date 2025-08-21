class Item < ApplicationRecord
  has_many :inventory_items
  has_many :characters, through: :inventory_items
  
  validates :name, presence: true
  validates :description, presence: true
  validates :item_type, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
