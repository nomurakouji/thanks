class DepartmentsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    respond_to do |format|
        if @department.save
          format.html { redirect_to department_url(@department), notice: "department was successfully created." }
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
    @departments = Department.all
  end

  def edit
  end

  def destroy
    @department.destroy

    respond_to do |format|
        format.html { redirect_to departments_url, notice: "Department was successfully destroyed." }
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
end
