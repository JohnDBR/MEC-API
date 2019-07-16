class CarouselsController < ApplicationController
  before_action :set_carousel, only: [:show, :update, :destroy]
  skip_before_action :get_current_user, only: [:show, :index]

  def index
    carousels = Carousel.all
    render_ok carousels
  end

  def show
    render_ok @carousel
  end

  def create
    carousel = Carousel.new(carousel_params)
    if carousel.save
      trans = Transmission.new
      trans.create_pictures(params, carousel, "carousel")
      if trans.errors.empty? or trans.empty_params
        render_ok carousel
      else
        render json: {errors: trans.errors, carousel: CarouselSerializer.new(carousel)}, status: :unprocessable_entity
      end
    else
      render json: carousel_picture.errors, status: :unprocessable_entity
    end
  end

  def update
    if not params[:update_img].eql? "true" or params[:update_img].nil?
      @carousel.update_attributes carousel_params 
      save_and_render @carousel
    else
      trans = Transmission.new
      trans.manage_pictures(params, @carousel, "carousel")
      if trans.errors.empty? and !trans.empty_params
        @carousel.update_attributes carousel_params 
        save_and_render @carousel
      else
        render json: {errors: trans.errors, user: @carousel}, status: :unprocessable_entity
      end
    end
  end

  def destroy
    render_ok @carousel.destroy
  end

  private
  def set_carousel
    @carousel = Carousel.find(params[:id])
  end

  def carousel_params
    params.permit(:name)
  end
end
