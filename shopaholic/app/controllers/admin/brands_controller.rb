class Admin::BrandsController < ApplicationController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]
  
  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
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
    #FIXME_AB: What if there are products associated with this brand?
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to admin_brands_url }
    end
  end

  private
  def set_brand
      @brand = Brand.find(params[:id])
    end

  def brand_params
    params.require(:brand).permit(:name, :logo)
  end
end
