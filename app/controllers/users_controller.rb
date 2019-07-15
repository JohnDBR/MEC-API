class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :get_current_user, only: [:show, :index]

  def index
    render_ok User.all.order(name: :asc)
  end

  def show
    render_ok @user
  end

  def create
    user = User.new user_params
    if user.save(context: :account_setup)
      render_ok user
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  def update
    if @user.id == @current_user.id
      @user.update_attributes user_params 
      save_and_render @user
    else
      render json: {authorization: 'Permission Denied'}, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.id == @current_user.id
      render_ok @user.destroy
    else
      render json: {authorization: 'Permission Denied'}, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:emails, :password, :phones, :username, :address)
  end
end
