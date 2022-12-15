class Public::PostsController < ApplicationController
 before_action :authenticate_customer!
 before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end


 def index
   @customer = current_customer
   @post = Post.new
   @posts = Post.all
 end

 def create
  @post = Post.new(post_params)
  @post.customer_id = current_customer.id
  if @post.save
   flash[:notice] = "You have created post successfully."
   redirect_to post_path(@post.id)
  else
   @customer = current_customer
   @posts = Post.all
   render :index
  end
 end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end


 def show
  @post = Post.find(params[:id])
  @customer = @post.customer
  @post_new = Post.new
  @post_comment = PostComment.new
 end

  def new
      @post = Post.new
  end

 private


 def post_params
  params.require(:post).permit(:team_name, :personnom, :base)
 end

  def ensure_correct_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to posts_path
    end
  end
end
