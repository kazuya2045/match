class Public::FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(customer_id: current_customer.id, post_id: params[:post_id])
    @favorite.save
    redirect_to posts_path
  end


  def destroy
    @favorite = Favorite.find_by(customer_id: current_customer.id, post_id: params[:post_id])
    @favorite.destroy
    redirect_to posts_path
  end
end
