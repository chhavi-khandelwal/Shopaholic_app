class Admin::ImagesController < ApplicationController

  before_action :set_image, only: [:show, :update, :destroy]
  def create
    @file = Image.new(image_params)
    if @file.save
      flash[:notice] = 'Image successfully uploaded'
    else
      flash[:error] = 'An error occured, image cannot be uploaded'
    end
  end

  def show
  end

  def update
    if @file.update(image_params)
      flash[:notice] = 'Image successfully updated'
    else
      flash[:error] = 'An error occured, image cannot be updated'
    end
    redirect_to @file.imageable
  end

  def destroy
    @file.photo = nil
    if @file.save
      flash[:notice] = 'Image successfully Removed'
    else
      flash[:error] = 'An error occured, image couldnot be removed'
    end
    redirect_to @file.imageable
  end

  private
    def image_params
      params.require(:image).permit(:file)
    end

end
