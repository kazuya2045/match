class Public::ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show
    #チャット相手
    @customer = Customer.find(params[:id])
    #ログイン中の会員の部屋情報を全て取得
    rooms = current_customer.customer_rooms.pluck(:room_id)
    #その中にチャットする相手とのルームがあるか確認
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)
    unless customer_rooms.nil?#ルームがあった
      #変数@roomに会員（自分と相手）と紐づいているroomを代入
      @room = customer_rooms.room
    else#ルームがなかった
      #ルームを新しく作る
      @room = Room.new
      #保存
      @room.save
      #自分の中間テーブルを作る
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
      #相手の中間テーブルを作る
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
    end
    #チャットの一覧用の変数
    @chats = @room.chats
    #チャットの投稿用の変数
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    #新しくチャットを作る
    @chat = current_customer.chats.new(chat_params)
    #140字以内なら保存
    render :validater unless @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end



  def reject_non_related
    customer = Customer.find(params[:id])
    unless current_customer.following?(customer) && customer.following?(current_customer)
      redirect_to posts_path
    end
  end
end
