class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search_result
    #検索モデル
    @range = params[:range]
    if @range == "Customer"
      #会員の検索方法と検索ワード
      @customers = Customer.looks(params[:search], params[:word])
    else
      #投稿の検索方法と検索ワード
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
