class Character < ApplicationRecord
  belongs_to :user
  has_many :inventory_items

  validates :name, presence: true, length: { minimum:1, maximum:100 }
  validates :class_name, :gender, :apperance, presence: true

end
