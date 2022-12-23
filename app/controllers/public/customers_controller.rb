class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:update]
  before_action :ensure_guest_customer, only: [:edit]

  def show
    #選択した会員の情報
    @customer = Customer.find(params[:id])
    #会員が投稿したもの
    @posts = @customer.posts
  end

  def index
    #ログインしている会員
    @customer = current_customer
    #会員すべて
    @customers = Customer.all
  end

  def edit
    is_matching_login_customer
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    #会員のアップデート
    if @customer.update(customer_params)
    #遷移先
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
    #会員情報を取り出し
    customer = Customer.find(params[:id])
    #ログインしている会員かどうか
    login_customer = current_customer
    #ログインしている会員じゃないとき
    if(customer.id != login_customer.id)
      #遷移先
      redirect_to customer_path(current_customer.id)
    end
  end
  #ゲストログイン関係
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
