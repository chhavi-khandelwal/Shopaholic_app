class Admin::BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_brand
  rescue_from ActiveRecord::RecordNotFound, with: :brand_not_found

  def index
    #FIXME_AB: Use pagination instead of displaying all records
    @brands = Brand.page(params[:page]).per(3)
    #fixed
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      #FIXME_AB: Since you are dealing with only one format, you can remove format.html block
      redirect_to admin_brands_path, notice: 'Brand was successfully created.'
    else
      render action: 'new'
    end
    #FIXED
  end

  def update
    if @brand.update(brand_params)
      redirect_to admin_brands_path, notice: 'Brand was successfully updated.'
    else
      render action: 'edit'
    end
    #FIXED
  end

  def destroy
    @brand.destroy
    redirect_to admin_brands_url
    #FIXED
  end

  private
  def set_brand
    #FIXME_AB: What if brand is not found with the id
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit(:name, :logo)
  end

  def cannot_destroy_brand
    redirect_to admin_brands_path, notice: 'Brand has products..It cannot be destroyed'
  end
  #FIXED
  def brand_not_found
    redirect_to admin_brands_path, notice: 'Brand doesnot exist'
  end
end
