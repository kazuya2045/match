class Public::PostCommentsController < ApplicationController

  def create
    #投稿の取り出し
    post = Post.find(params[:post_id])
    #comment = PostComment.new(post_comment_params) comment.user_id = current_user.idと同じ
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_id = post.id
    #保存
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    #投稿の取り出し
    post = Post.find(params[:post_id])
    #コメントの取り出し
    @comment = PostComment.find(params[:id])
    #削除
    @comment.destroy
    redirect_to post_path(post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
