class PhotosController < ApplicationController
  def index
  end

  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:id])
    @photo.reload
  end

  def create
    photo = Photo.new(photo_params)
    if photo.valid?
      photo.save
      redirect_to photo_path(photo)
    else
      redirect_to new_photo_path
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def image
    photo_params["image"]
  end
end
