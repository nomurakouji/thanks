class Admin::UsersController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :admin_user
  def index
    @users = User.all
    @departments = Department.all
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    @user = User.find(params[:id])
      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_path, notice: "user was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
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

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
