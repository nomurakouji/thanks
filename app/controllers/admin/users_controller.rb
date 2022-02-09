class Admin::UsersController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :admin_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # @post.user_id = current_user.id

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    # @users = User.all
    @d = User.ransack(params[:q])
    @deparmetn = @d.result(distinct: true)
    
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path(@user), notice: "user was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
    params.require(:user).permit(:name, :email, :image, :image_cache, :department_id, :password, :password_confirmation)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end


end
