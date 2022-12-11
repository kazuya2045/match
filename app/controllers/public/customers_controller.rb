class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit,:update]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
  end

  def index
    @customer = current_customer
    @customers = Customer.all
    @post = Post.new
  end

  def edit
    is_matching_login_customer
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     flash[:notice] = "You have updated user successfully."
    redirect_to customer_path(@customer.id)
    else
     render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end

  def is_matching_login_customer
    customer = Customer.find(params[:id])
    login_customer = current_customer
    if(customer.id != login_customer.id)
      redirect_to customer_path(current_customer.id)
    end
  end
end
