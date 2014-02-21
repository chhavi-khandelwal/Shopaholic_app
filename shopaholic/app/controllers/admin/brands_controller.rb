class Admin::BrandsController < Admin::AdminsController
  before_action :set_brand, only: [:update, :destroy, :cannot_destroy_brand]
  
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_brand

  def index
    @brands = Brand.page(params[:page]).per(8)
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      redirect_to admin_brands_path, notice: 'Brand was successfully created.'
    else
      render action: :new
    end
  end

  def update
    if @brand.update(brand_params)
      #FIXME_AB: As a good practice try to add the name/details of the record updated or created in the flash message
      redirect_to admin_brands_path, notice: "Brand #{ @brand.name } was successfully updated."
      #fixed
    else
      #FIXME_AB: As a good practice you should use symbol whenever you can. render action: :edit would work in the same way
      render action: :edit
      #fixed
    end
  end

  def destroy
    if @brand.destroy
    #FIXME_AB: Its a good practice to add a flash message whenever you do a redirect
      redirect_to admin_brands_url, notice: "Brand #{ @brand.name } was successfully destroyed."
    else
      redirect_to admin_brands_url, alert: "Brand #{ @brand.name } was not successfully destroyed."
    end
    #fixed
  end

  private
  def set_brand
    #FIXME_AB: What if brand is not found with the id
    @brand = Brand.find_by(id: params[:id])
    redirect_to root_url, alert: "Brand not found" if(@brand.nil?)
    #fixed
  end

  def brand_params
    params.require(:brand).permit(:name, :logo)
  end

  def cannot_destroy_brand
    #FIXME_AB: Does it also work with delete?
    redirect_to admin_brands_path, notice: "Brand #{ @brand.name } has products..It cannot be destroyed"
  end

end
