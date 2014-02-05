class Admin::SizesController < ApplicationController
  before_action :set_product, only: [:new, :create]
  before_action :set_size, only: [:update, :destroy, :edit]

  def new
    @size = Size.new
    @colors = @product.colors
  end

  def create
    @size = Size.new(size_params)
    respond_to do |format|
      if @size.save
        format.js { } 
      else
        @colors = @product.colors
        format.js { render action: 'new' }
      end
    end
  end

  def edit
    @product = @size.color.product
    @colors = @product.colors
  end

  def update
    @product = @size.color.product 
    respond_to do |format|
      if @size.update(size_params)
        format.js {  }
      else
        @colors = @product.colors
        format.js { render action: 'edit' }
      end
    end
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
    @product = Product.find_by(id: params[:product_id])
  end

  def size_params
    params.require(:size).permit(:name, :price, :discounted_price, :quantity, :color_id)
  end
end
