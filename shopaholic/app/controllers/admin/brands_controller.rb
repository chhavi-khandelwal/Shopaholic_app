class Admin::BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_brand

  def index
    #FIXME_AB: Use pagination instead of displaying all records
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        #FIXME_AB: Since you are dealing with only one format, you can remove format.html block
        format.html { redirect_to admin_brands_path, notice: 'Brand was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to admin_brands_path, notice: 'Brand was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_brands_url }
    end
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
    respond_to do |format|
      format.html { redirect_to admin_brands_path, notice: 'Brand has products..It cannot be destroyed' }
    end
  end
end
