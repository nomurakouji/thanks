class UsersController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    @d = User.ransack(params[:q])
    @deparmetn = @d.result(distinct: true)
  end

  def edit
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    #@department = Department.find(params[:department_id])
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
  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_post
    @user = User.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :image, :image_cache, :department_id)
  end

end
