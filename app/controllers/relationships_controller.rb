class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # フォローされたタイミングで、フォローを通知するための変数を作成
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
