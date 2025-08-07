class QuestItem < ApplicationRecord
  belongs_to :quest
  belongs_to :item
end
