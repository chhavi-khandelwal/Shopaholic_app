class Admin::SizesController < Admin::AdminsController
  before_action :set_product, only: [:new, :create, :size_not_found, :update]
  before_action :set_size, only: [:update, :destroy, :edit]

  #FIXME_AB: This way we are handling any RecordNotFound as size_not_found. Not the right way. Should handle using if else condition where we expect this type of situation can occur. I am against this approach. Should not be done at any place in the application
  rescue_from ActiveRecord::RecordNotFound, with: :size_not_found


  def new
    @size = Size.new
  end

  def create
    #FIXME_AB: You should use color.size.build
    @size = Size.new(size_params)
    respond_to do |format|
      if @size.save
        #FIXME_AB: Why we need empty format blocks. Also since here we have only one format, lets remove them
        format.js { } 
      else
        format.js { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @size.update(size_params)
        format.js {  }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def edit
    #FIXME_AB: Since we have a @size available we can directly use @size.color.product wherever needed. SO we don't need to define @product variable
    @product = @size.color.product
  end

  def destroy
    @size.destroy
    respond_to do |format|
      format.js { }
    end
  end

  private
  def set_size
    @size = Size.find(params[:id])
  end

  def set_product
    @product = Product.find_by(params.require(:product_id))
  end

  def size_params
    params.require(:size).permit(:name, :sku, :price, :discounted_price, :quantity, :color_id)
  end

  def size_not_found
    redirect_to admin_product_path(@product), notice: 'Size doesnot exist'
  end
end
