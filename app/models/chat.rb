class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  #文字制限140文字以内
  validates :message, presence: true, length: { maximum: 140 }
end
