class Customers::SessionsController < Devise::SessionsController
  #ゲストログイン関係
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to customer_path(customer), notice: 'guestuserでログインしました。'
  end
end