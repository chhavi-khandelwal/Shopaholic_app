class Admin::ProductsController < Admin::AdminsController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page]).per(8)
  end

  def new
    @product = Product.new
    @categories = Category.all
    @brands = Brand.all
  end

  def show
    #FIXME_AB: on the other hand you should do @product.colors.sizes.where(...)
    @sizes = @product.sizes.where(color_id: @product.colors).order(:color_id)
    #FIXME_AB: Also use symbol in above line order(:color_id)
    #fixed
  end
  
  def destroy
    if(@product.destroy)
    #FIXME_AB: Flash message missing
      redirect_to admin_products_url(@product.category), notice: "Product #{ @product.title } was destroyed successfully."
    else
      redirect_to admin_products_url(@product.category), alert: "Product #{ @product.title } was not destroyed successfully."
    end
    #fixed
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "Product #{ @product.title } was successfully created."
    else
      render action: :new
    end
  end

  def edit
    @brands = Brand.all
    @categories = Category.all
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path(@product.category), notice: "Product #{ @product.title } was successfully updated."
    else
      render action: :edit
    end
  end

  private
  def set_product
    @product = Product.find_by(id: params[:id])
    redirect_to admin_products_path, alert: 'Product Not found' if(@product.nil?)
  end

  def product_params
    params.require(:product).permit(:title, :description, :category_id, :brand_id)
  end
end
