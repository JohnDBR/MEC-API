class ProductOptionsController < ApplicationController
  before_action :set_product_option, only: [:destroy]

  def create
    product_option = ProductOption.new(product_option_params)
    if product_option.save
      render_ok product_option
    else
      render json: product_option.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render_ok @product_option.destroy
  end

  private
  def set_product_option
    @product_option = ProductOption.find(params[:id])
  end

  def product_option_params
    params.permit(:name, :product_id)
  end
end
