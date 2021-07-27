class BrandsController < ApplicationController
  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  # SINGLE IMAGE
  # def create
  #   brand = Brand.new brand_params

  #   if params[:brand][:image].present?
  #     req = Cloudinary::Uploader.upload params[:brand][:image]
  #     brand.image = req["public_id"]
  #   end
  #   brand.save
  #   redirect_to brand_path(brand)
  # end

  # MULTIPLE IMAGES
  def create
    brand = Brand.new brand_params

    if params[:brand][:images].present?
      params[:brand][:images].each do |image|
        req = Cloudinary::Uploader.upload image
        brand.images << req["public_id"]
      end
    end

    brand.save
    redirect_to brand_path
  end

  def edit
    @brand = Brand.find params[:id]
  end

  def update
    brand = Brand.find params[:id]

    if params[:brand][:image].present?
      req = Cloudinary::Uploader.upload params[:brand][:image]
      brand.image = req["public_id"]
    end

    brand.update_attributes brand_params
    redirect_to brand_path(brand)
  end

  def show
    @brand = Brand.find params[:id]
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

end
