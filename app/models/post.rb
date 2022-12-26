class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  #投稿で空欄が無いようにするバリデーション
  validates :team_name, presence:true
  validates :personnom, presence:true
  validates :base, presence:true

  #引数で渡されたユーザidがFavoritesテーブル内に存在するかどうか
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  #投稿の検索方法分岐
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
