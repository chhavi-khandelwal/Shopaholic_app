class Admin::ColorsController < ApplicationController
  before_action :set_color, only: [:update, :destroy, :edit, :cannot_destroy_color]
  before_action :set_product, only: [:new, :create, :color_not_found]

  rescue_from ActiveRecord::RecordNotFound, with: :color_not_found
  rescue_from ActiveRecord::DeleteRestrictionError, with: :cannot_destroy_color

  def new
    @color = Color.new
  end


  def create
    @color = @product.colors.build(color_params)
    respond_to do |format|
      if @color.save
        #FIXME_AB: Why defining another instance variable @colros. You can use @product.colors wherever needed
        #fixed
        #FIXME_AB: Spelling mistake in below line
        flash.now[:notice] = "#{ @color.name } color created successfully."
        #fixed
        redirect_to admin_product_path(@product), notice: 'Color was successfully created.'
      else
        render action: 'new'
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update(color_params)
        #FIXME_AB: Spelling mistake in below line
        flash.now[:notice] = "#{ @color.name } color updated successfully."
        #fixed 
        format.html { redirect_to admin_product_path(@color.product), notice: 'Color was successfully updated.' }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      flash.now[:notice] = "#{ @color.name } color destroyed successfully."
      format.js {}
    end
  end

  private
  def set_color
    @color = Color.find(params[:id])
  end

  def set_product
    @product = Product.find(params.require(:product_id))
  end

  def color_params
    params.require(:color).permit(:name, images_attributes: [:id, :file])
  end

  def cannot_destroy_color
    flash.now[:notice] = "#{ @color.name } has sizes..It cannot be destroyed."
    render partial: 'notice'
  end

  def color_not_found
    redirect_to admin_product_path(@product), notice: 'Category doesnot exist'
  end
end
