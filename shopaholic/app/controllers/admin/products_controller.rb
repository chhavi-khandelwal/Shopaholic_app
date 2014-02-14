class Admin::ProductsController < Admin::AdminsController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :product_not_found


  def index
    @products = Product.page(params[:page]).per(3)
  end

  def new
    @product = Product.new
    @categories = Category.all
    @brands = Brand.all
  end

  def show
    @sizes = Size.where(color_id: @product.colors).order("color_id")
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

  def product_not_found
    redirect_to admin_products_path, notice: 'Product doesnot exist'
  end
end
