class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
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
    #     format.html { redirect_to post_url(@user), notice: "User was successfully updated." }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache)
  end

end
