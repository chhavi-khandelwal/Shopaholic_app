class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    # Rails.logger.debug "@@@@@@@@@@@@@@@@@#{params}"
    if params[:category_id]
      @products = Product.by_category(params[:category_id])
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_category_products_url(@product.category) }
    end
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_category_products_path, notice: 'Product was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_category_products_path(@product.category), notice: 'Product was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :category_id)
  end
end
