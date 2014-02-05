class Admin::ImagesController < ApplicationController

  before_action :set_image, only: [:show, :update, :destroy]
  def create
    @display_pic = Image.new(image_params)
    if @display_pic.save
      flash[:notice] = 'Image successfully uploaded'
    else
      flash[:error] = 'An error occured, image cannot be uploaded'
    end
  end

  def show
  end

  def update
    if @display_pic.update(image_params)
      flash[:notice] = 'Image successfully updated'
    else
      flash[:error] = 'An error occured, image cannot be updated'
    end
    redirect_to @display_pic.imageable
  end

  def destroy
    @display_pic.photo = nil
    if @display_pic.save
      flash[:notice] = 'Image successfully Removed'
    else
      flash[:error] = 'An error occured, image couldnot be removed'
    end
    redirect_to @display_pic.imageable
  end

private
  def image_params
    params.require(:image).permit(:display_pic)
  end

end
end
