class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :product_not_found


  def index
    # if params[:category_id]
    #   @products = Product.by_category(params[:category_id])
    # else
      @products = Product.page(params[:page]).per(3)
    # end
  end

  def new
    @product = Product.new
    @categories = Category.all
    @brands = Brand.all
  end

  def show
    #FIXME_AB: Why we need to define these two instance variables, all these can be fetched from @product when required
    # @sizes = Size.where(color_id: @colors).order("color_id")
  end
  
  def destroy
    @product.destroy
    redirect_to admin_products_url(@product.category)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path(@product.category), notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :category_id, :brand_id)
  end

  #FIXED
  def product_not_found
    redirect_to admin_products_path, notice: 'Product doesnot exist'
  end
end
