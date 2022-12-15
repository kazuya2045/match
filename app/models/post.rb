class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  validates :team_name, presence:true
  validates :personnom, presence:true
  validates :base, presence:true


  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("team_name LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("team_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("team_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("team_name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end
