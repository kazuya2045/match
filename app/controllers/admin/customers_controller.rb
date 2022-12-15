class Admin::CustomersController < ApplicationController

  def index
    @customer = current_customer
    @customers = Customer.all
    @post = Post.new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
  end
end
