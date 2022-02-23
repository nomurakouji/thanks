class LikesController < ApplicationController
  before_action :set_variables
  def create
    # いいねを通知するメソッド
    # いいねが押された時、つまりlikes#createが要求された時にいいね通知がnotificationsテーブルに登録される必要がある
    # postモデルでインスタンスメソッドを新しく作って、likes#createに記述してこの動きを実装
    @post.create_notification_by(current_user)

    # いいねのlike_idを作成し、Likeモデル経由でuser_idとpost_idをDBに持たせる
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    # redirect_to posts_path
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:post_id]).destroy
    # Notificationの該当のIDを探して削除する。
    Notification.find_by(visiter_id: current_user, post_id: params[:post_id]).destroy
    # redirect_to posts_path
  end
  
  # いいねの非同期にも使用
  def set_variables
    @post = Post.find(params[:post_id])
    @follow = Post.where(user_id: [*current_user.following_ids]).order(created_at: :desc)
  end
end
