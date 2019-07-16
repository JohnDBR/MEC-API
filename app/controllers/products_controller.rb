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
      if params[:options]
        errors = {}
        hash = params[:options].split(/,/)
        hash.each_with_index do |o,i|
          product_option = ProductOption.new(name: o.strip, product_id: product.id)
          unless product_option.save
            errors["option#{i}"] = product_option.errors
          end
        end
        if errors.empty?
          render_ok product
        else
          render json: {errors: errors, product: ProductSerializer.new(product)}, status: :unprocessable_entity
        end
      else
        render json: product, status: :created
      end
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
