class PhotosController < ApplicationController
  def index
  end

  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    photo = Photo.create(photo_params)
    redirect_to photo_path(photo)
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def image
    photo_params["image"]
  end
end
