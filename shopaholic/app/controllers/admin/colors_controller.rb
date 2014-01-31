class Admin::ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  def new
    @color = Color.new
    @product = Product.find(product_params)
  end

  def create
    @product = Product.find(product_params)
    @product.colors.build(color_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path(@product), notice: 'Color was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to admin_product_path(@color.product), notice: 'Color was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      format.html { redirect_to admin_product_path(@color.product) }
    end
  end

  private
  def set_color
    @color = Color.find(params[:id])
  end

  def product_params
    params.require(:product_id)
  end

  def color_params
    params.require(:color).permit(:name)
  end
end
