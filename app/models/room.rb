class Room < ApplicationRecord
  has_many :chats
  has_many :customer_rooms
end
