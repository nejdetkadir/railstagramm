class Room < ApplicationRecord
  belongs_to :user

  has_many :participants
  has_many :messages
end
