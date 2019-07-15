class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]
  skip_before_action :get_current_user, only: [:show, :index]

  def index
    clients = Client.all
    render_ok clients
  end

  def show
    render_ok @client
  end

  def create
    client = Client.new(client_params)
    if client.save
      render_ok client
    else
      render json: client.errors, status: :unprocessable_entity
    end
  end

  def update
    if @client.update(client_params)
      render_ok @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render_ok @client.destroy
  end

  private
  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.permit(:name, :url, :picture)
  end
end
