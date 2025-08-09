class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :characters

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quests
end

          :recoverable, :rememberable, :validatable
end

