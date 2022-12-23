class Public::FavoritesController < ApplicationController
  def create
    #サインインしている会員がどの投稿にいいねをしたか
    @favorite = Favorite.new(customer_id: current_customer.id, post_id: params[:post_id])
    #保存
    @favorite.save
    redirect_to posts_path
  end


  def destroy
    #誰がいいねしたか探す
    @favorite = Favorite.find_by(customer_id: current_customer.id, post_id: params[:post_id])
    #削除
    @favorite.destroy
    redirect_to posts_path
  end
end
