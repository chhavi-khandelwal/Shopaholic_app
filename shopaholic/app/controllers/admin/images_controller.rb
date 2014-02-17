class Admin::ImagesController < Admin::AdminsController

  before_action :set_image, only: [:show, :update, :destroy]
  def create
    #FIXME_AB: Shouldn't we use color.images.build ?
    @file = Image.new(image_params)
    if @file.save
      flash[:notice] = 'Image successfully uploaded'
    else
      #FIXME_AB: Typo
      flash[:error] = 'An error occured, image cannot be uploaded'
    end
  end

  def show
  end

  def update
    if @file.update(image_params)
      flash[:notice] = 'Image successfully updated'
    else
      #FIXME_AB: Typo
      flash[:error] = 'An error occured, image cannot be updated'
    end
    redirect_to @file.imageable
  end

  def destroy
    #FIXME_AB: this is basically image.photo. Looks something confusing image.attachment or image.file make sense
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
