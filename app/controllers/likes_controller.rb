class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post.create_notification_by(current_user)
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    redirect_to posts_path
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
    # Notificationの該当のIDを探して削除する。
    # post_id = 100 解除 => post_idが引っ張れる。
    redirect_to posts_path
  end

end
