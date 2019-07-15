class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  skip_before_action :get_current_user, only: [:show, :index]

  def index
    products = Product.all
    render_ok products
  end

  def show
    render_ok @product
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render_ok @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render_ok @product.destroy
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :description, :picture)
  end
end
