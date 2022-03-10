class UsersController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(7)
    # @d = User.ransack(params[:q])
    # @deparment = @d.result(distinct: true)
  end

  def edit
  end

  def show
    # 特定のユーザーが投稿した記事を抽出
    @aaa = Post.where(user_id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to users_path, notice: "ユーザーを編集しました！"
      else
        render :edit
      end
  end
  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "ユーザーを削除しました" }
      format.json { head :no_content }
    end
  end

  private
  def set_post
    @user = User.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :department_id, :password, :password_confirmation)
  end

end
