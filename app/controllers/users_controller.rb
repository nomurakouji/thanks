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
    @post = Post.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        redirect_to users_path, notice: "ユーザーを編集しました！"
      else
        render :edit
      end
      # respond_to do |format|
      #   if @user.update(user_params)
      #     format.html { redirect_to users_path(@user), notice: "user was successfully updated." }
      #     format.json { render :show, status: :ok, location: @user }
      #   else
      #     format.html { render :edit, status: :unprocessable_entity }
      #     format.json { render json: @user.errors, status: :unprocessable_entity }
      #   end
      # end
    # end
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
