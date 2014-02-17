class Admin::ColorsController < Admin::AdminsController
  before_action :set_color, only: [:update, :destroy, :edit, :cannot_destroy_color]
  before_action :set_product, only: [:new, :create, :color_not_found]

  rescue_from ActiveRecord::RecordNotFound, with: :color_not_found
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_color

  def new
    @color = Color.new
  end


  def create
    @color = @product.colors.build(color_params)
    if @color.save
      flash.now[:notice] = "#{ @color.name } color created successfully."
      redirect_to admin_product_path(@product), notice: 'Color was successfully created.'
    else
      redirect_to admin_product_path(@product), alert: 'Image format not supported'
    end
  end

  def update
    respond_to do |format|
      #FIXME_AB: Since we are handelling only one format so we can avoid using format.html
      if @color.update(color_params)
        format.html { redirect_to admin_product_path(@color.product), notice: "#{ @color.name } was successfully updated." }
      else
        format.html { redirect_to :back, alert: "#{ @color.name } wasn't successfully updated." }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      flash.now[:notice] = "#{ @color.name } color destroyed successfully."
      #FIXME_AB: Why this blank format.js{}. I think we don't need it.
      format.js {}
    end
  end

  private
  def set_color
    @color = Color.find(params[:id])
  end

  def set_product
    @product = Product.find(params.require(:product_id))
  end

  def color_params
    params.require(:color).permit(:name, images_attributes: [:id, :file])
  end

  def cannot_destroy_color
    flash.now[:notice] = "#{ @color.name } has sizes..It cannot be destroyed."
    render partial: 'notice'
  end

  def color_not_found
    redirect_to admin_product_path(@product), notice: 'Category doesnot exist'
  end
end
