class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]
  skip_before_action :get_current_user, only: [:show, :index]

  def index
    employees = Employee.all
    render_ok employees
  end

  def show
    render_ok @employee
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: employee, status: :created
    else
      render json: employee.errors, status: :unprocessable_entity
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
  end

  private
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.permit(:name, :quote, :picture)
  end
end
