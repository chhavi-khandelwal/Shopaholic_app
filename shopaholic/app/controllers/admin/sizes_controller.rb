class Admin::SizesController < ApplicationController
  before_action :set_product, only: [:new, :create, :size_not_found, :update]
  before_action :set_size, only: [:update, :destroy, :edit]

  rescue_from ActiveRecord::RecordNotFound, with: :size_not_found


  def new
    @size = Size.new
  end

  def create
    @size = Size.new(size_params)
    respond_to do |format|
      if @size.save
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
