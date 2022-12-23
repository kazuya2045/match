class Admin::CustomersController < ApplicationController

  def index
    #会員全員の情報
    @customers = Customer.all
  end

  def show
    #選択した会員の情報
    @customer = Customer.find(params[:id])
    #選択した会員が投稿したもの一覧
    @posts = @customer.posts
  end
end
