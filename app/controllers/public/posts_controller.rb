class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def edit
    @post = Post.find(params[:id])
  end

  def update
    #投稿を取り出し
    @post = Post.find(params[:id])
    #投稿をアップデート
    if @post.update(post_params)
      #アップデート後の遷移先
      redirect_to post_path(@post.id)
    else
      #アップデートできなかった時の遷移先
      render :edit
    end
  end


  def index
    #サインインしている会員
    @customer = current_customer
    #投稿全て
    @posts = Post.all
  end

  def create
    #newで取得した内容を@postに引数として渡す
    @post = Post.new(post_params)
    #@postの引数の会員idとサインインしている会員は同じ
    @post.customer_id = current_customer.id
    #保存
    if @post.save
    #遷移先
      redirect_to post_path(@post.id)
    else
      @customer = current_customer
      @posts = Post.all
    render :index
    end
  end

  def destroy
    #投稿の取り出し
    post = Post.find(params[:id])
    #削除
    post.destroy
    #遷移先
    redirect_to posts_path
  end


  def show
    #投稿の取り出し
    @post = Post.find(params[:id])
    #投稿した会員は誰か
    @customer = @post.customer
    #コメント生成
    @post_comment = PostComment.new
  end

  def new
    #生成
    @post = Post.new
  end

  private


  def post_params
    params.require(:post).permit(:team_name, :personnom, :base)
  end

  def ensure_correct_customer
    #投稿の取り出し
    @post = Post.find(params[:id])
    #投稿した会員とサインインしている会員が違う
    unless @post.customer == current_customer
      #遷移先
      redirect_to posts_path
    end
  end
end
