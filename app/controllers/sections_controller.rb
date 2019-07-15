class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :update, :destroy]
  skip_before_action :get_current_user, only: [:show, :index]

  def index
    sections = Section.all
    render_ok sections
  end

  def show
    render_ok @section
  end

  def create
    section = Section.new(section_params)
    if section.save
      render json: section, status: :created
    else
      render json: section.errors, status: :unprocessable_entity
    end
  end

  def update
    if @section.update(section_params)
      render json: @section
    else
      render json: @section.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @section.destroy
  end

  private
  def set_section
    @section = Section.find(params[:id])
  end

  def section_params
    params.permit(:name, :description)
  end
end
