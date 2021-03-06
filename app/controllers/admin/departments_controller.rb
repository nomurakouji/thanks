class Admin::DepartmentsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :admin_user
  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    respond_to do |format|
        if @department.save
          format.html { redirect_to admin_departments_path, notice: "部門を作成しました" }
          format.json { render :show, status: :created, location: @department }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @department.errors, status: :unprocessable_entity }
        end
    end
  end

  def show
  end
  
  def index
    @departments = Department.all.all.page(params[:page]).per(7)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to admin_departments_path(@department), notice: "部門を更新しました" }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @department.destroy

    respond_to do |format|
        format.html { redirect_to admin_departments_path, notice: "部門を削除しました" }
        format.json { head :no_content }
      end
  end

  private
  def set_post
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end

