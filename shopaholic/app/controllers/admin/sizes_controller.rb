class Admin::SizesController < Admin::AdminsController
  before_action :set_product, only: [:new, :create]
  before_action :set_size, only: [:update, :destroy, :edit]

  #FIXME_AB: This way we are handling any RecordNotFound as size_not_found. Not the right way. Should handle using if else condition where we expect this type of situation can occur. I am against this approach. Should not be done at any place in the application
  #fixed-used if condition

  def new
    @size = Size.new 
    render partial: 'form'
  end

  def create
    #FIXME_AB: You should use color.size.build
    @size = Size.new(size_params)
    if @size.save
      render json: { size: @size, color: @size.color.name }
      #FIXME_AB: Why we need empty format blocks. Also since here we have only one format, lets remove them
      #fixed
    else
      render json: { error: @size.errors.full_messages.first }
    end

  end

  def update
    if @size.update(size_params)
      flash[:notice] = "Successfully updated size"
    else
      render action: :edit
    end
  end

  def destroy
    @size.destroy
  end

  private
  def set_size
    @size = Size.find_by(id: params[:id])
    redirect_to admin_products_path, alert: 'Size Not found' if(@size.nil?)
  end

  def set_product
    @product = Product.find_by(id: params[:product_id])
    redirect_to admin_products_path, alert: 'Product Not found' if(@product.nil?)
  end

  def size_params
    params.require(:size).permit(:name, :sku, :price, :discounted_price, :quantity, :color_id)
  end

end
